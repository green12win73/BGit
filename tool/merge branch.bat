@echo off
::调用配置bat，设置临时环境变量
call "%~dp0\config"
echo *************************************************************
echo *      批量合并代码：请确认当前工程分支是否可以合并代码     *  
echo *************************************************************
::开启变量延迟，可以在for循环中通过!var!的方式引用变量
setlocal enabledelayedexpansion
::遍历当前目录下的包含.git的文件夹名称
set /a totoalProjects=0
for /d %%i in (*) do (
	if not %%i==[Filter] (
		if exist "%cd%\%%i\.git\" (
			set projectIndex=!totoalProjects!
			set projectName=%%i
			set /a totoalProjects+=1
			echo !totoalProjects!: !projectName!
			::添加数组,包含：编号、名称、次数
			set Obj[!projectIndex!].num=!totoalProjects!
			set Obj[!projectIndex!].name=!projectName!
			set Obj[!projectIndex!].count=0
		)
	)
)
:break
::接受传入参数:需要操作的工程名称编号
set /p projectNums=输入需要合并分支的工程名称的编号（逗号或者空格隔开）：
::接受传入参数:操作的分支号
set /p branchName=输入需求号或者完整的远程分支名称：
::判断输入的工程编号是否符合要求
set /a index=0
::将最终执行的工程拼接成字符串
set /a currentProjectsStr=0
for %%i in (%projectNums%) do (
	::判断输入的工程编号是否在指定的范围内，超出指定范围则提示错误
	if %%i LSS 1 (
		echo 输入工程编号错误...
		goto break
	) else (
		::不能超过最大工程编号
		if %%i GTR %totoalProjects% (
			echo 输入工程编号错误...
			goto break
		) else (
			set /a index=%%i-1
			set /a projectName=0
			::找到指定下标的数组，判断是否输入了重复的工程编号
			for /f "usebackq delims==. tokens=1-3" %%I in (`set Obj[!index!]`) do (
				::判断数组中的count属性是否为0，如果为0表示没有出现重复，否则表示编号重复，直接退出
				if %%J==count (
					if not %%K==0 (
						echo 输入工程编号重复...  
						goto break
					)
				) else if %%J==name (set projectName=%%K)
				
			)
			::将为1的结果设置的到数组的count属性，表示该编号已经解析过，用于后面判断是否出现编号重复
			set Obj[!index!].count=1
			::将会进行本次操作的工程拼接成字符串
			if !currentProjectsStr! EQU 0 ( 
				set currentProjectsStr=!projectName!
			) else ( 
				set currentProjectsStr=!currentProjectsStr!,!projectName!
			)
		)
	)
)
:loopInput
echo 请选择分支名称类型 1:复合型(如：%Obj[0].name%_%branchName%) 2:极简型(如：%branchName%)
::选择分支类型
set /p branchType=
::判断输入的参数是否错误,如果错误，让用户继续选择
echo %branchType%|findstr "[1-2]">nul && echo 开始执行...... || goto loopInput 
::遍历工程，完成分支切换和更新操作
for %%i in (%currentProjectsStr%) do (
	if exist "%cd%\%%i\.git\" (
		if !branchType!==1 (set branch=%%i_!branchName!) else (set branch=!branchName!)
		echo git %%i merge branch remotes/origin/!branch!...
		@cd %cd%\%%i && @git pull && @git merge --no-ff --no-commit remotes/origin/!branch!
		echo ********************************分支合并完成尚未提交,请检查****************************************
	)
)
:break
::关闭变量延迟
setlocal disabledelayedexpansion
pause