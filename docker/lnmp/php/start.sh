#!/bin/bash

# 启动 Supervisor（后台）
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

# 启动 php-fpm（作为主进程，保持容器运行）
exec /usr/sbin/php-fpm8.2 -F
