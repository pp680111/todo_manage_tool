; Name of Installer
Outfile "todoManageInstaller.exe"

; Default installation directory
InstallDir "$PROGRAMFILES\todo_manage"

; ����ע����ֵ��ȡ��Ĭ�ϰ�װĿ¼
InstallDirRegKey HKLM "Software\todo_manage" "Install_Dir"

; Request application privileges for Windows Vista and later
RequestExecutionLevel admin

DirText "��ѡ������Ҫ��װ�����λ��" "Ŀ��λ��" "���" "���밲װ·��"

Page directory
Page instfiles

Section "MainSection"
  ;�������·��Ϊ�û�ѡ��İ�װĿ¼
  SetOutPath $INSTDIR

  ; �����ļ�����װĿ¼
  File /r ".\build\windows\x64\runner\Release\*.*"

  ; д��ע������¼��װĿ¼
  WriteRegStr HKLM "Software\todo_manage" "Install_Dir" $INSTDIR

  ; ����Uninstaller
  WriteUninstaller "$INSTDIR\uninstaller.exe"

  ; ������ʼ�˵���ݷ�ʽ��ʾ����
  ; CreateShortCut "$SMPROGRAMS\MyApplication.lnk" "$INSTDIR\myapp.exe"
SectionEnd

Section "Uninstall"
    ; ж��ʱɾ�������ļ�����Ŀ¼
    RMDir /r "$INSTDIR"

    ; ɾ��ע�����
    DeleteRegKey HKLM "Software\todo_manage"

    ; ɾ����ʼ�˵���ݷ�ʽ
    ; Delete "$SMPROGRAMS\MyApplication.lnk"
SectionEnd