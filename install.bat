@echo off
%1 %2
ver|find "5.">nul&&goto Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
echo 开始注册信息...
::"批量切换分支并更新;批量创建并切换分支;批量更新所有分支;批量合并分支"
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\BGit" /v subCommands /t REG_SZ /d "Switch;Create;Update;Merge" 
::添加子菜单:批量切换分支并更新
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Switch" /d "Switch Update"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Switch\command" /d "cmd.exe /c \"%~dp0\tool\switch branch.bat\""
::添加子菜单:批量创建并切换分支
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Create" /d "Create Switch | No Commit"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Create\command" /d "cmd.exe /c \"%~dp0\tool\create branch.bat\""
::添加子菜单:批量更新所有分支
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Update" /d "Update"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Update\command" /d "cmd.exe /c \"%~dp0\tool\update branch.bat\""
::添加子菜单:批量合并分支
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Merge" /d "Merge Switch | No Commit"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Merge\command" /d "cmd.exe /c \"%~dp0\tool\merge branch.bat\""
echo 结束注册信息...

pause