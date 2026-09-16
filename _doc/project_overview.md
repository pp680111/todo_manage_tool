# 项目概览与现状记录

> 检查日期：2026-09-16  
> 检查范围：项目结构、技术栈、核心业务代码、数据模型、平台适配、静态分析和测试基线

## 1. 项目定位

`todo_manage` 是一个使用 Flutter 开发的本地待办管理工具。项目的主要目标是在不依赖网络服务的情况下，使用本地 SQLite 数据库记录和管理待办事项。

虽然仓库包含 Android、Linux、Web 和 Windows 工程目录，但当前代码的初始化逻辑、系统托盘、单实例和窗口管理功能均明显面向 Windows 桌面端。因此，现阶段应将其视为一个以 Windows 为主要运行平台的 Flutter 应用。

## 2. 技术栈

| 领域 | 实现 |
| --- | --- |
| UI 框架 | Flutter / Material 3 |
| 编程语言 | Dart |
| 本地数据库 | SQLite |
| ORM / 数据访问 | Drift |
| 状态及刷新通知 | Provider、ChangeNotifier |
| 桌面窗口管理 | `window_manager` |
| 系统托盘 | `tray_manager` |
| 单实例运行 | `flutter_single_instance` |
| 日期时间选择 | `omni_datetime_picker` |
| 可搜索下拉框 | `drop_down_search_field` |
| 安装包 | NSIS 脚本及 Windows 安装程序 |

当前 `pubspec.yaml` 声明的 Dart SDK 最低约束为 `^3.5.3`。本次检查环境为 Flutter 3.47.2、Dart 3.13.2。

## 3. 目录结构

```text
todo_manage_tool/
├── _doc/                         # 设计与项目文档
├── images/                       # 应用图标等资源
├── lib/
│   ├── main.dart                 # 应用入口
│   ├── model/                    # Drift 表、DAO、DTO
│   │   ├── app_database.dart
│   │   ├── category/
│   │   ├── todo_thing/
│   │   └── todo_thing_progress/
│   ├── utils/                    # 日期时间工具
│   └── widget/                   # 页面与通用组件
│       ├── category/
│       ├── todo_thing/
│       └── platform/windows/
├── test/                         # 当前测试文件
├── android/ linux/ web/ windows/ # Flutter 平台工程
├── nsis_script.nsi               # Windows 安装脚本
└── pubspec.yaml                  # 项目及依赖配置
```

非生成 Dart 代码约 2,000 行，整体规模较小。

## 4. 总体架构

项目采用较直接的 Widget + DAO 结构，没有单独的 service 或 repository 层：

```text
Flutter Widget
    └── AppDatabase 单例
          ├── TodoThingDao
          ├── CategoryDao
          └── TodoThingProgressDao
                └── SQLite
```

界面组件直接通过 `AppDatabase.instance` 调用 DAO。列表刷新主要由自定义分页控制器以及 Provider/ChangeNotifier 完成。

主要入口和模块：

- `lib/main.dart`：初始化 Flutter、窗口管理、单实例和系统托盘。
- `lib/widget/main_page.dart`：应用主页面，通过 NavigationRail 切换“全部”和“分类”。
- `lib/model/app_database.dart`：Drift 数据库单例、表和 DAO 注册、数据库文件路径。
- `lib/widget/prefetch_scroll_list_view.dart`：通用分页和滚动预加载组件。
- `lib/widget/platform/windows/`：Windows 窗口与托盘事件处理。

## 5. 核心业务功能

### 5.1 待办事项

当前实现包括：

- 新增、查看、编辑和删除待办事项；
- 按标题关键词搜索；
- 按状态和分类筛选；
- 记录详情、所属分类和截止时间；
- 在列表中快速切换完成状态；
- 分页加载待办列表。

待办状态包括：

| 值 | 含义 |
| --- | --- |
| 0 | 未开始 |
| 1 | 执行中 |
| 2 | 已完成 |
| 3 | 已超时 |

目前没有发现根据截止时间自动转换为“已超时”状态的逻辑。

### 5.2 分类

当前实现包括：

- 分类列表；
- 分类名称搜索；
- 新增、编辑和删除分类；
- 新建或编辑待办时选择分类。

原始设计文档描述了多级树形分类，但当前界面和查询尚未实现分类的逐层浏览。数据表中保留了 `parentCategoryId` 字段。

### 5.3 进度记录

已保存的待办事项可以添加多条进度记录，支持：

- 添加进度文本；
- 查看完整内容；
- 标记进度是否完成；
- 删除进度记录。

### 5.4 Windows 桌面能力

当前 Windows 端支持：

- 单实例运行，重复启动时聚焦已有窗口；
- 系统托盘图标和右键菜单；
- 最小化后隐藏任务栏图标；
- 通过托盘重新显示窗口；
- 关闭窗口前弹出确认对话框。

## 6. 数据模型

### 6.1 Category

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 自增主键 |
| name | String | 分类名称 |
| parentCategoryId | String? | 上级分类 ID |
| createTime | DateTime | 创建时间 |
| updateTime | DateTime | 更新时间 |

`parentCategoryId` 当前是字符串，而分类主键 `id` 是整数，类型不一致。若继续实现树形分类，建议统一为可空整数并建立自引用外键。

### 6.2 TodoThing

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 自增主键 |
| title | String | 标题 |
| detail | String? | 详细描述 |
| status | int | 待办状态 |
| categoryId | int? | 所属分类 ID |
| createTime | DateTime | 创建时间 |
| deadlineTime | DateTime? | 截止时间 |
| updateTime | DateTime | 更新时间 |

### 6.3 TodoThingProgress

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 自增主键 |
| todoThingId | int | 所属待办 ID |
| content | String | 进度内容 |
| isFinished | bool | 是否完成 |
| createTime | DateTime | 创建时间 |
| updateTime | DateTime | 更新时间 |

目前没有在 Drift 表定义中发现显式外键约束或级联删除规则。

## 7. 数据库与存储

数据库通过 `AppDatabase.instance` 以单例方式访问，`schemaVersion` 当前为 1。

数据库文件位于系统应用文档目录下：

- Debug：`zst_todo_tools/debug/app_database.sqlite`
- Release：`zst_todo_tools/release/app_database.sqlite`

当前实现没有显式创建数据库文件的父目录，也没有提供 schema 升级迁移策略。首次启动的目录创建行为以及未来表结构升级都需要重点验证。

## 8. 静态分析与测试基线

### 8.1 静态分析

执行 `flutter analyze` 后，共报告 63 条 warning/info，没有发现 analyzer error。问题主要包括：

- Widget 中存在未声明为 `final` 的可变字段；
- 异步间隔后继续使用 `BuildContext`，且缺少 `mounted` 检查；
- `MainPage.initState()` 没有调用 `super.initState()`；
- 窗口和托盘 listener 添加后没有在 `dispose()` 中移除；
- 存在未使用的变量和 import；
- 文件名、枚举值等不符合 Dart 推荐命名风格；
- 表单校验方法存在可能不返回值的静态分析告警。

### 8.2 自动化测试

执行 `flutter test` 失败：

- `test/lang_test.dart` 的内容全部被注释，没有有效的 `main()`；
- `test/widget_test.dart` 仅打印 `kDebugMode`，没有测试断言；
- 当前没有覆盖数据库 DAO、分页逻辑或主要 Widget 交互的有效测试。

因此，现阶段项目基本没有自动化回归保护。

## 9. 已识别的主要风险

### 9.1 分类名称异步填充存在竞争

`TodoThingDTOMapper` 在转换待办 DTO 后，通过一个未等待的 `async void` 方法查询并填充分类名称。调用方收到列表时，分类名称可能仍未写入 DTO，并且完成填充后不会主动触发界面刷新。

建议让映射方法返回 `Future<TodoThingDTO>` 或 `Future<List<TodoThingDTO>>`，由 DAO 等待分类增强完成后再返回数据；也可以直接通过 Drift join 一次性查询待办和分类。

### 9.2 分页列表可能构建空 Widget

`PrefetchScrollListView` 会为“下一页加载位置”增加一个列表项，但对应的 `itemBuilder` 可能返回 `null`。Flutter 的列表构建器应返回有效 Widget，这可能造成运行时异常或不稳定行为。

建议为加载位置返回明确的进度指示器或空占位 Widget，并在返回数据条数小于 `pageSize` 时直接更新 `hasNextPage`。

### 9.3 数据库父目录可能不存在

数据库连接直接打开多层路径下的文件，没有先调用 `Directory.create(recursive: true)`。在全新用户环境中，SQLite 文件可能因父目录不存在而创建失败。

### 9.4 缺少数据库迁移

数据库只声明了 `schemaVersion = 1`，没有升级策略。后续新增字段、修改字段类型或添加约束时，旧数据库无法得到可靠迁移。

### 9.5 关联数据可能成为孤立记录

删除待办事项时不会同步删除进度记录；删除分类时也不会清理或解除待办关联。由于没有外键和级联规则，数据库可能逐渐积累孤立数据。

### 9.6 平台适配不完整

应用入口没有平台判断，直接初始化 Windows 窗口、系统托盘和单实例功能，并依赖 `dart:io`。仓库虽然包含多个平台目录，但 Android、Linux 和 Web 目前不能视为已经完整支持。

### 9.7 生命周期与刷新逻辑需要整理

- Window 和 Tray listener 没有保存实例及主动移除；
- 部分异步回调可能在 Widget 已卸载后访问 `context`；
- 待办列表通过隐藏的 `Consumer` 在 build 阶段触发刷新，可读性和稳定性较差；
- 多个 `TextEditingController` 在 build 中临时创建，没有统一管理和释放。

## 10. 建议的后续处理顺序

1. 修复数据库目录创建、DTO 异步映射和分页空 Widget 等运行时风险。
2. 为数据库增加外键、级联策略和 schema migration。
3. 修复 Widget 生命周期、listener 释放及异步 `BuildContext` 使用问题。
4. 补充 DAO 单元测试和主要页面 Widget 测试，恢复可用的测试基线。
5. 明确平台范围；若只支持 Windows，清理或隔离其他平台入口；若需要多端，则增加平台判断和适配层。
6. 再实现多级分类、超时状态自动计算等尚未完成的设计需求。
7. 最后集中清理 lint、命名和不可变 Widget 等代码质量问题。

## 11. 当前工作区说明

检查时仓库位于 `master` 分支，并与 `origin/master` 对齐。工作区原本已经存在以下未提交内容：

- `.gitignore` 的修改；
- Linux 和 Windows 插件注册生成文件的修改；
- `test/widget_test.dart` 的修改；
- 四个尚未跟踪的 Drift `.g.dart` 生成文件。

本次整理只新增本文档，没有修改业务源码或覆盖上述既有变更。

## 12. 相关设计文档

- [Flutter 桌面宠物实现方案](desktop_pet_flutter_implementation.md)
