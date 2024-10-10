## 需求

* 记录todo事项，需要记录的内容包括事项概要，事件详细描述，多条的进度记录，是否已完成
* 需要提供todo事项的分类过滤查看
* 两个显示方式，一是直接显示所有TODO事项，二是显示分类，按照分类逐层深入，直到进入最终层次，显示todo列表
* 使用数据库进行记录

## 设计

### 数据模型

todo事项

Category事件分类

| 名称               | 数据类型 | 描述       |
| ------------------ | -------- | ---------- |
| id                 | String   |            |
| name               | String   | 分类名称   |
| parent_category_id | String   | 上级分类id |
| create_time        | time     |            |
| update_time        | time     |            |

TodoThing

| 名称            | 数据类型 | 描述           |
|---------------| -------- | -------------- |
| id            | String   | 事件id         |
| title         | String   | 事件的标题     |
| detail        | String   | 事件的详细描述 |
| status        | enum     | 事件状态枚举   |
| category_id   | String   | 所属事件分类id |
| create_time   | time     |                |
| deadline_time | time     |                |
| update_time   | time     |                |

TodoThingProgress

| 名称          | 数据类型 | 描述           |
| ------------- | -------- | -------------- |
| id            | String   | id             |
| content       | String   | 进度描述文本   |
| todo_thing_id | String   | 关联待办事项id |
| create_time   | time     |                |
| update_time   | time     |                |