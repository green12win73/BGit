@echo off
%1 %2
ver|find "5.">nul&&goto Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
echo ��ʼɾ��ע��ľ���Ϣ...
::ɾ������ע���
Reg DELETE "HKEY_CLASSES_ROOT\Directory\Background\shell\BGit" /f
Reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Switch" /f
Reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Create" /f
Reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Update" /f
Reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Merge" /f
echo ����ɾ��ע��ľ���Ϣ...
pause