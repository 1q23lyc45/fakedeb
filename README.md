# fakedeb
生成空白deb安装包，支持Debian类linux系统

单文件形式，需要依赖dpkg-deb(如果你在用RHEL系列，请先安装dpkg-deb再使用)

## 用法
```
bash fakedeb.sh <软件名>
```

## TODO
* [ ] 增加参数实现打包完自动安装，一个命令搞定
* [X] 自定义打包版本号
