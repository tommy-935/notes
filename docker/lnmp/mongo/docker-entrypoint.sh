#!/bin/bash
set -e

# 如果 keyfile 不存在，就生成
if [ ! -f /etc/mongo-keyfile ]; then
  echo "🔑 Generating MongoDB keyfile..."
  openssl rand -base64 756 > /etc/mongo-keyfile
  chmod 600 /etc/mongo-keyfile
  chown mongodb:mongodb /etc/mongo-keyfile
fi

# 继续执行 MongoDB 的默认 entrypoint
exec docker-entrypoint.sh "$@"
