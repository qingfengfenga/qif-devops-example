::
:: copy-file-zip.bat 要复制的文件夹 目标位置
:: eg: copy-file.bat ./project/app/bin ./project/launcher/data
::

@echo off
chcp 65001 > nul

REM 参数检查
if "%~1"=="" (
    echo 请提供源文件夹路径作为第一个参数
    goto :eof
)

if "%~2"=="" (
    echo 请提供目标文件夹路径作为第二个参数
    goto :eof
)

REM 设置变量
set "source_folder=%~1"
set "target_folder=%~2"

REM 复制源文件夹内的所有内容到目标文件夹（覆盖重复文件）
xcopy /s /e /i /y "%source_folder%\*" "%target_folder%"

echo 文件夹内容已成功复制到：%target_folder%

pause
