@echo off
::��������bat��������ʱ��������
call "%~dp0\config"
echo *************************************************************
echo *      �����ϲ����룺��ȷ�ϵ�ǰ���̷�֧�Ƿ���Ժϲ�����     *  
echo *************************************************************
::���������ӳ٣�������forѭ����ͨ��!var!�ķ�ʽ���ñ���
setlocal enabledelayedexpansion
::������ǰĿ¼�µİ���.git���ļ�������
set /a totoalProjects=0
for /d %%i in (*) do (
	if not %%i==[Filter] (
		if exist "%cd%\%%i\.git\" (
			set projectIndex=!totoalProjects!
			set projectName=%%i
			set /a totoalProjects+=1
			echo !totoalProjects!: !projectName!
			::�������,��������š����ơ�����
			set Obj[!projectIndex!].num=!totoalProjects!
			set Obj[!projectIndex!].name=!projectName!
			set Obj[!projectIndex!].count=0
		)
	)
)
:break
::���ܴ������:��Ҫ�����Ĺ������Ʊ��
set /p projectNums=������Ҫ�ϲ���֧�Ĺ������Ƶı�ţ����Ż��߿ո��������
::���ܴ������:�����ķ�֧��
set /p branchName=��������Ż���������Զ�̷�֧���ƣ�
::�ж�����Ĺ��̱���Ƿ����Ҫ��
set /a index=0
::������ִ�еĹ���ƴ�ӳ��ַ���
set /a currentProjectsStr=0
for %%i in (%projectNums%) do (
	::�ж�����Ĺ��̱���Ƿ���ָ���ķ�Χ�ڣ�����ָ����Χ����ʾ����
	if %%i LSS 1 (
		echo ���빤�̱�Ŵ���...
		goto break
	) else (
		::���ܳ�����󹤳̱��
		if %%i GTR %totoalProjects% (
			echo ���빤�̱�Ŵ���...
			goto break
		) else (
			set /a index=%%i-1
			set /a projectName=0
			::�ҵ�ָ���±�����飬�ж��Ƿ��������ظ��Ĺ��̱��
			for /f "usebackq delims==. tokens=1-3" %%I in (`set Obj[!index!]`) do (
				::�ж������е�count�����Ƿ�Ϊ0�����Ϊ0��ʾû�г����ظ��������ʾ����ظ���ֱ���˳�
				if %%J==count (
					if not %%K==0 (
						echo ���빤�̱���ظ�...  
						goto break
					)
				) else if %%J==name (set projectName=%%K)
				
			)
			::��Ϊ1�Ľ�����õĵ������count���ԣ���ʾ�ñ���Ѿ������������ں����ж��Ƿ���ֱ���ظ�
			set Obj[!index!].count=1
			::������б��β����Ĺ���ƴ�ӳ��ַ���
			if !currentProjectsStr! EQU 0 ( 
				set currentProjectsStr=!projectName!
			) else ( 
				set currentProjectsStr=!currentProjectsStr!,!projectName!
			)
		)
	)
)
:loopInput
echo ��ѡ���֧�������� 1:������(�磺%Obj[0].name%_%branchName%) 2:������(�磺%branchName%)
::ѡ���֧����
set /p branchType=
::�ж�����Ĳ����Ƿ����,����������û�����ѡ��
echo %branchType%|findstr "[1-2]">nul && echo ��ʼִ��...... || goto loopInput 
::�������̣���ɷ�֧�л��͸��²���
for %%i in (%currentProjectsStr%) do (
	if exist "%cd%\%%i\.git\" (
		if !branchType!==1 (set branch=%%i_!branchName!) else (set branch=!branchName!)
		echo git %%i merge branch remotes/origin/!branch!...
		@cd %cd%\%%i && @git pull && @git merge --no-ff --no-commit remotes/origin/!branch!
		echo ********************************��֧�ϲ������δ�ύ,����****************************************
	)
)
:break
::�رձ����ӳ�
setlocal disabledelayedexpansion
pause