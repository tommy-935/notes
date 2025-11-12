#!/bin/bash
set -e

NODE_NAME=$(hostname)
DATA_DIR="/var/lib/mysql"

# 确保运行目录存在
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# 如果是 galera1 并且没有 grastate.dat，则 bootstrap
if [ "$NODE_NAME" = "galera1" ] && [ ! -f "$DATA_DIR/grastate.dat" ]; then
    echo "Bootstrapping Galera cluster from $NODE_NAME..."
    exec docker-entrypoint.sh mysqld --wsrep-new-cluster
else
    echo "Starting Galera node: $NODE_NAME..."
    exec docker-entrypoint.sh mysqld
fi
