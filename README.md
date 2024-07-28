# fakedeb
生成空白deb安装包，支持Debian类linux系统

单文件形式，需要依赖dpkg-deb(如果你在用RHEL系列，请先安装dpkg-deb再使用)

## 用法
```
bash fakedeb.sh <软件名>
```

## TODO
增加参数实现打包完自动安装，一个命令搞定

## 这个软件是怎么来的
### 捆绑？
Termux官方源的python-pip捆绑clang。众所周知，clang及它的依赖大小有400MB以上。所以，这就造成了
```
~ $ apt install python-pip
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  clang gdbm glib libandroid-posix-semaphore
  libcompiler-rt libexpat libffi libllvm libsqlite
  libxml2 lld llvm make ncurses-ui-libs ndk-sysroot
  pkg-config python
Suggested packages:
  python-tkinter
Recommended packages:
  python-ensurepip-wheels
The following NEW packages will be installed:
  clang gdbm glib libandroid-posix-semaphore
  libcompiler-rt libexpat libffi libllvm libsqlite
  libxml2 lld llvm make ncurses-ui-libs ndk-sysroot
  pkg-config python python-pip
0 upgraded, 18 newly installed, 0 to remove and 0 not upgraded.
Need to get 100 MB of archives.
After this operation, 640 MB of additional disk space will be used.
Do you want to continue? [Y/n]
```
还是加上02norecommend情况下，不然捆绑更多。对于我一个gcc粉，而且32G手机的用户来说我能忍吗？这简直比某高速下载器还流氓！

### 盘它! 
开干！Baidu一圈，找到了这个大佬的文章：
https://mp.weixin.qq.com/s/2f8ajsgVahG0inu0tbnJUA 
特别感谢！

它的原理就是骗过apt和dpkg，不过，又是各种mkdir又是chmod，还要再装个fakeroot，甚至deb放其他电脑还不能用！

so，这个脚本诞生了！一键打包空包deb，完美绕过apt依赖检测！再也不用一个一个创建假deb了！  
1.自动修复control文件权限，免chmod  
2.自动创建deb文件树，再也不用一个一个mkdir  
3.打包自带root所有者，通杀一切Linux文件系统！  
下面是效果（可以看出直接砍了500MB，够装一堆照片了）
```
~ $ apt install python-pip
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  gdbm glib libandroid-posix-semaphore libexpat
  libffi libsqlite make ncurses-ui-libs pkg-config
  python
Suggested packages:
  python-tkinter
Recommended packages:
  python-ensurepip-wheels
The following NEW packages will be installed:
  gdbm glib libandroid-posix-semaphore libexpat
  libffi libsqlite make ncurses-ui-libs pkg-config
  python python-pip
0 upgraded, 11 newly installed, 0 to remove and 0 not upgraded.
Need to get 14.3 MB of archives.
After this operation, 106 MB of additional disk space will be used.
Do you want to continue? [Y/n]
```
