::
:: create_repository.bat 项目位置 生成仓库的位置
:: eg: create_repository.bat project/installer repository/installer/v1.0.0
::

@echo off
chcp 65001 > nul

REM 项目位置
set "Component_Package=%1"
REM 生成repository位置
set "Release_Package=%2"

REM 调用 repogen 工具，传入指定参数
repogen -p "%Component_Package%\packages" "%Release_Package%"

pause