# 用途

QIF Devops Example（Qt Installer Framework Devops Example ）维护了一个文件结构，以及基础脚本，用于快速启动一个相对完善的 Windows 下 Qt Installer Framework 编译项目，支持命令化编译，方便自动化构建。

## 功能

### 文件夹

- config 用来存放生成配置文件
- nginx 用来存放 nginx 的配置文件，提供
- project 用来存放安装器代码，和业务代码
- release 用来存放需要发布的文件，使用 nginx 文件服务代理，对外下载
- repository 用来存放在线安装和更新的内容，使用 nginx 文件服务代理，支持在线安装和在线更新

### 基础脚本

> 由于 Windows 环境对命令化操作支持不佳，这里提供了几个脚本，来提供基础的功能

- copy-file-zip.bat 压缩指定文件夹，以` CommitID + 当前时间 `命名压缩文件，并复制到指定位置。

- copy-file.bat 复制指定文件夹到指定位置。

- create_installer_offline.bat 创建安装器的离线安装版本，命名格式为 `自定义名称 + CommitID + 生成时间`。

- create_installer_online.bat 创建安装器的在线安装版本，命名格式为 `自定义名称 + CommitID + 生成时间`。

- create_repository.bat 创建支持 online 在线安装的库。

- qt-build.bat 编译 qt 程序的一个示例脚本。

- update_repository.bat 创建支持在线更新的库。


## 文件服务器

使用 nginx 文件服务代理分别代理`./release`、`./repository`两个文件夹，提供文件服务。

- http://localhost:80/release/

- http://localhost:80/repository/

## 自动化场景

> 3、4 可以是同一个文件夹，也可以分开放两个文件夹

1、编译安装器在线安装包

```
create_installer_offline.bat project\installer\main\meta\package.xml project\installer release\installer install-dev_v.1.0.0_setup_offline
```

2、编译安装器在线安装包

```
create_installer_online.bat project\installer\main\meta\package.xml project\installer release\installer install-dev_v.1.0.0_setup_online
```

3、创建在线安装仓库

```
create_repository.bat project/installer repository/installer/v1.0.0
```

4、创建在线更新仓库

```
update_repository.bat project\installer repository\installer\update
```

## 参考：
https://github.com/lostsummer/qif_example
