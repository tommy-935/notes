# 使用官方 MongoDB 镜像
FROM mongo:7.0

COPY docker-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

# 设置容器内时区（可选）
ENV TZ=Asia/Shanghai

# 创建数据挂载目录（可选）
VOLUME ["/data/db"]

# 默认 MongoDB 的端口是 27017
EXPOSE 27017

# MongoDB 官方镜像会自动运行 mongod
# 如果你有额外配置，可覆盖 ENTRYPOINT 或 CMD
