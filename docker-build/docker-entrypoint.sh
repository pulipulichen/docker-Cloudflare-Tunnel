#!/bin/bash

# 檢查是否設置了 TARGET_URL
if [ -z "$TARGET_URL" ]; then
    echo "環境變數 TARGET_URL 未設定"
    exit 1
fi

# 嘗試連線 nginx，最多重試30次，每次間隔10秒
for i in {1..30}; do
    http_code=$(curl -Ls -o /dev/null -w "%{http_code}" "$TARGET_URL")
    
    if [[ "$http_code" =~ ^2|3 ]]; then
        echo "nginx is reachable."
        break
    else
        echo "Waiting for nginx... ($i)"
        sleep $RETRY_INTERVAL_SECONDS
    fi
done

sleep $DELAY_SECONDS

/cloudflared --url $TARGET_URL