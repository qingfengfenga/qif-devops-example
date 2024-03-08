::
:: 命令化编译脚本，CMD下直接执行即可生成运行文件，运行前需要修改本地 QT 和 Visual Studio 的路径，以及配置 qmake.exe 和 jom.exe 的环境变量。
:: 
:: 第一次使用时，需要先使用 QT 编辑器编译一次，来生成具体的编译文件夹，如果知道 QT 生成的具体文件名称，也可以手动创建文件夹。
::

@echo off

REM 设置项目目录为脚本所在目录
set "project_directory=%~dp0"

REM 进入项目目录
cd %project_directory%

REM 启动 Qt 的终端
start "" "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Qt 5.13.2\5.13.2\MSVC 2017 (64-bit)\Qt 5.13.2 (MSVC 2017 64-bit).lnk"

REM 等待 Qt 的终端启动
timeout /t 5

REM 设置 Visual Studio 环境变量
set "vs_installation_dir=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community"
call "%vs_installation_dir%\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64

REM 设置 Qt 的环境变量
set QTDIR=C:\Qt\Qt5.13.2
set PATH=%QTDIR%\5.13.2\msvc2017_64\bin;%QTDIR%\Tools\QtCreator\bin;%PATH%

REM 进入项目 build 目录
cd build-install-Desktop_Qt_5_13_2_MSVC2017_64bit-Release

REM 运行 qmake
qmake.exe %project_directory%\src\dtlauncher.pro -spec win32-msvc "CONFIG+=qtquickcompiler"

REM 使用 jom 编译项目
jom.exe -f Makefile qmake_all
jom.exe -f Makefile.Release

REM 暂停以查看输出
pause
