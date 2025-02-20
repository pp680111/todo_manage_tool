; Name of Installer
Outfile "todoManageInstaller.exe"

; Default installation directory
InstallDir "$PROGRAMFILES\todo_manage"

; 设置注册表键值读取的默认安装目录
InstallDirRegKey HKLM "Software\todo_manage" "Install_Dir"

; Request application privileges for Windows Vista and later
RequestExecutionLevel admin

DirText "请选择您想要安装软件的位置" "目标位置" "浏览" "输入安装路径"

Page directory
Page instfiles

Section "MainSection"
  ;设置输出路径为用户选择的安装目录
  SetOutPath $INSTDIR

  ; 复制文件到安装目录
  File /r ".\build\windows\x64\runner\Release\*.*"

  ; 写入注册表项，记录安装目录
  WriteRegStr HKLM "Software\todo_manage" "Install_Dir" $INSTDIR

  ; 创建Uninstaller
  WriteUninstaller "$INSTDIR\uninstaller.exe"

  ; 创建开始菜单快捷方式（示例）
  ; CreateShortCut "$SMPROGRAMS\MyApplication.lnk" "$INSTDIR\myapp.exe"
SectionEnd

Section "Uninstall"
    ; 卸载时删除所有文件和子目录
    RMDir /r "$INSTDIR"

    ; 删除注册表项
    DeleteRegKey HKLM "Software\todo_manage"

    ; 删除开始菜单快捷方式
    ; Delete "$SMPROGRAMS\MyApplication.lnk"
SectionEnd