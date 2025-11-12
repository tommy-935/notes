FROM mariadb:10.11

LABEL maintainer="tony01"

# 使用官方环境变量初始化 root 用户
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_USER=sstuser
ENV MYSQL_PASSWORD=password
# ENV MYSQL_DATABASE=mydb  # 如果需要创建默认数据库

# 安装 galera-4
RUN apt-get update && apt-get install -y galera-4 && rm -rf /var/lib/apt/lists/*

# 复制 Galera 配置
COPY galera.cnf /etc/mysql/conf.d/galera.cnf
RUN chmod 644 /etc/mysql/conf.d/galera.cnf

# 复制自定义 entrypoint，如果需要特殊处理
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]

