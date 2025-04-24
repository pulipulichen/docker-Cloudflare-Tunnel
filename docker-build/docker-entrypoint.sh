#!/bin/bash

# 檢查是否設置了 TARGET_URL
if [ -z "$TARGET_URL" ]; then
    echo "環境變數 TARGET_URL 未設定"
    exit 1
fi

# 嘗試連線 nginx，最多重試30次，每次間隔10秒
for i in {1..30}; do
    if curl -s --head $TARGET_URL | grep "200 OK" > /dev/null; then
        echo "nginx is reachable."
        break
    else
        echo "Waiting for nginx... ($i)"
        sleep 10
    fi
done

/cloudflared --url $TARGET_URL