#!/bin/bash

# 获取当前的日期，格式化成YYYY-MM-DD
VERSION=$(date +%Y-%m-%d)

# 检查传入的软件名参数，检测通过后赋值变量SOFT_NAME
if [ "$#" -ne 1 ]; then
    echo "fakedeb-shell v1.0.0 (2024-06-30 16:54:21 CST)"
    echo "Usage: $0 <SOFT_NAME>"
    exit 1
fi
SOFT_NAME="$1"

# 创建deb包的临时目录
TEMP_DIR=$(mktemp -d)
DEB_NAME="${SOFT_NAME}_${VERSION}_all.deb"
CONTROL_DIR="${TEMP_DIR}/DEBIAN"

# 创建必要的目录结构
mkdir -p "${CONTROL_DIR}"
chmod 755 "${CONTROL_DIR}"

# 创建空的DEBIAN/control文件
cat << EOF > "${CONTROL_DIR}/control"
Package: ${SOFT_NAME}
Version: ${VERSION}
Architecture: all
Maintainer: Your Name <youremail@example.com>
Description: An fake Debian package for ${SOFT_NAME}
EOF

# 使用dpkg-deb打包
if dpkg-deb --build --root-owner-group "${TEMP_DIR}"; then
    # 移动输出文件位置
    mv "${TEMP_DIR}.deb" ./${DEB_NAME}
    # 显示创建的deb包路径
    echo "Successful."
    echo "Output: ${DEB_NAME}"
else
    # 检查dpkg-deb命令是否未安装
    if [ $? -eq 127 ]; then
        echo "Error: dpkg-deb is not installed. Please install it before running this script."
    else
        echo "Error: An error occurred while building the Debian package."
    fi
fi

# 清理：删除临时目录
rm -rf "${TEMP_DIR}"
