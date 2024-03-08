::
:: copy-file-zip.bat 要复制的文件夹 目标位置
::eg: copy-file-zip.bat project\app\bin release\app
::

@echo off
chcp 65001 > nul

REM 参数检查
if "%~1"=="" (
    echo 请提供项目位置作为第一个参数
    goto :eof
)

if "%~2"=="" (
    echo 请提供目标位置作为第二个参数
    goto :eof
)

REM 设置变量
set "project_location=%~1"
set "target_location=%~2"

REM 切换到项目目录
cd /d "%project_location%" || (
    echo 无法切换到项目目录，请检查目录是否存在
    goto :eof
)

REM 获取当前 Commit ID
for /f "delims=" %%a in ('git rev-parse --short HEAD') do set CommitID=%%a

REM 检查是否成功获取 Commit ID
if not defined CommitID (
    echo 无法获取 Commit ID，请检查是否在 Git 仓库中
    goto :eof
)

REM 切换回脚本所在目录
cd /d "%~dp0"

REM 获取当前日期和时间，精确到分钟
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set datetime=%%a
set datestamp=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%

REM 构建目标文件夹名
set target_folder=%target_location%\%CommitID%_%datestamp%

REM 创建临时文件夹
set temp_folder=%temp%\temp_folder_%random%
md "%temp_folder%"

REM 复制文件到临时文件夹
xcopy /E /Y "%project_location%\*" "%temp_folder%\"

REM 获取压缩文件名
set zip_file=%target_folder%.zip

REM 使用 PowerShell 压缩文件夹
powershell Compress-Archive -Path "%temp_folder%\*" -DestinationPath "%zip_file%"

REM 检查是否成功压缩
if %errorlevel% neq 0 (
    echo 压缩失败
    goto :eof
)

REM 删除临时文件夹
rd /s /q "%temp_folder%"

echo 文件夹已成功压缩到：%zip_file%

pause