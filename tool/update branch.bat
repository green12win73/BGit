@echo off
::��������bat��������ʱ��������
call "%~dp0\config"
echo *************************************************************
echo *          �������·�֧�����µ�ǰĿ¼�����еĹ���         *  
echo *************************************************************
for /d %%i in (*) do (
	if not %%i==[Filter] (
		if exist "%cd%\%%i\.git\" (
			echo git %%i
			@cd %cd%\%%i && @git pull
			echo ********************************���̸������****************************************
		)
	)
)
pause