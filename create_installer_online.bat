::
:: create_installer_online.bat 配置文件 项目位置 生成的exe存放位置 自定义的包名
:: eg: create_installer_online.bat project\installer\main\meta\package.xml project\installer release\installer install-dev_v.1.0.0_setup_online
::

@echo off
chcp 65001 > nul

REM 配置文件
set "Create_Config=%1"
REM 项目位置
set "Component_Package=%2"
REM 生成exe位置
set "Release_Package=%3"
REM 包名
set "Custom_Part=%4"

REM 获取短的项目位置的 CommitID
for /f %%i in ('git -C "%Component_Package%" rev-parse --short HEAD') do set "CommitID=%%i"

REM 获取当前日期时间
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set "datetime=%%a"
set "CurrentTime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%"

REM 包名
set "EXE_Name=%Custom_Part%_%CommitID%_%CurrentTime%.exe"

REM 调用 binarycreator 工具，传入指定参数
binarycreator --online-only -c "%Create_Config%" -p "%Component_Package%\packages" "%Release_Package%\%EXE_Name%"

pause