@echo off
%1 %2
ver|find "5.">nul&&goto Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
echo ��ʼע����Ϣ...
::"�����л���֧������;�����������л���֧;�����������з�֧;�����ϲ���֧"
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\BGit" /v subCommands /t REG_SZ /d "Switch;Create;Update;Merge" 
::����Ӳ˵�:�����л���֧������
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Switch" /d "Switch Update"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Switch\command" /d "cmd.exe /c \"%~dp0\tool\switch branch.bat\""
::����Ӳ˵�:�����������л���֧
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Create" /d "Create Switch | No Commit"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Create\command" /d "cmd.exe /c \"%~dp0\tool\create branch.bat\""
::����Ӳ˵�:�����������з�֧
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Update" /d "Update"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Update\command" /d "cmd.exe /c \"%~dp0\tool\update branch.bat\""
::����Ӳ˵�:�����ϲ���֧
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Merge" /d "Merge Switch | No Commit"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Merge\command" /d "cmd.exe /c \"%~dp0\tool\merge branch.bat\""
echo ����ע����Ϣ...

pause