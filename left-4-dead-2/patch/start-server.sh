#!/bin/bash
set -e

# 首次启动时，将 /app-patch 中的所有文件复制到 /app（覆盖同名文件）
if [ ! -f /app/PATCHED ]; then
    cp -rf /app-patch/. /app/
    touch /app/PATCHED
fi

/app/srcds_run -game left4dead2 \
    -insecure \
    -port 27015 \
    -tickrate 64 \
    +exec server.cfg \
    +nomaster \
    "$@"