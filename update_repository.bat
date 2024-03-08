:: 
:: update_repository.bat 项目位置 生成的更新仓库位置
:: eg: update_repository.bat project\installer repository\installer\update
::

@echo off
chcp 65001 > nul

REM 项目位置
set "Component_Package=%1"
REM 生成repository位置
set "Release_Package=%2"

:: 重新生成
::repogen --update-new-components -p "%Component_Package%\packages_update" "%Release_Package%"

:: 更新
:: REM 调用 repogen 工具，传入指定参数
repogen --update -p "%Component_Package%\packages_update" "%Release_Package%"

pause