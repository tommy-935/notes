1. Dockerfile:
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

2. docker-entrypoint.sh:
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

3. init-mongo.js:
// 初始化数据库、用户，并创建集合等
const adminDb = db.getSiblingDB('admin');

// 创建管理员用户（可选，如果使用 MONGO_INITDB_ROOT_USERNAME/ROOT_PASSWORD 已自动创建）
adminDb.createUser({
  user: "root",
  pwd: "root",
  roles: [
    { role: "root", db: "admin" }
  ]
});

// 切换到目标业务数据库
const appDb = db.getSiblingDB('tb_migration_prod');

// 创建应用用户（可选，根据实际使用可添加）
appDb.createUser({
  user: "appuser",
  pwd: "123456",
  roles: [
    { role: "readWrite", db: "tb_migration_prod" }
  ]
});

// 示例：预创建一个集合（可省略）
appDb.createCollection("migration_logs");

// 可选：插入初始化文档
appDb.migration_logs.insertOne({
  message: "MongoDB initialized successfully",
  createdAt: new Date()
});

4. init-replica.js:
rs.initiate({
  _id: "tb-migration",
  members: [
    { _id: 0, host: "mongo:27017" }
  ]
})

5. init-replica.sh:
docker exec -it mongo mongosh -u root -p root --authenticationDatabase admin /docker-entrypoint-initdb.d/init-replica.js

6. docker-compose.yml:
mongo:
    container_name: mongo
    build: ./mongo
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: root
      MONGO_INITDB_DATABASE: tb_migration_prod
    command: ["mongod", "--replSet", "tb-migration", "--keyFile", "/etc/mongo-keyfile"] # 添加了 command: ["mongod", "--replSet", "tb-migration"] 表示启动时以副本集名 tb-migration 启动。
    volumes:
      - mongo_data:/data/db
      # 如果你有初始化脚本可以加上这一行：
      # - ./mongo/mongo-keyfile:/etc/mongo-keyfile:ro
      - ./mongo/init-mongo.js:/docker-entrypoint-initdb.d/init-mongo.js:ro
      - ./mongo/init-replica.js:/docker-entrypoint-initdb.d/init-replica.js:ro
    networks:
      - appnet
    entrypoint: ["/usr/local/bin/custom-entrypoint.sh"]

以上配置有问题吗？为什么会导致 appuser无权登录验证呢？还有副本集配置是否正确？
