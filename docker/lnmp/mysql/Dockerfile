# 使用官方MySQL镜像（推荐）
FROM mysql:8.0

# 设置环境变量（替换你的配置）
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=test
ENV MYSQL_USER=appuser
ENV MYSQL_PASSWORD=123456

# 安装vim（需要切换到root用户，安装后切回mysql用户）
# RUN apt update && apt install -y vim && rm -rf /var/lib/apt/lists/*
# RUN apk add --no-cache vim


# 复制自定义MySQL配置文件
# COPY mysqld.cnf /etc/mysql/conf.d/
COPY --chown=mysql:mysql --chmod=0644 mysqld.cnf /etc/mysql/conf.d/


# 复制初始化脚本（会自动执行）
COPY init.sql /docker-entrypoint-initdb.d/

# 暴露端口（官方镜像已包含，显式声明）
EXPOSE 3306

# 无需手动配置权限和启动命令，官方镜像已优化处理
