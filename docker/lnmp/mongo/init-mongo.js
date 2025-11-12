// 初始化数据库、用户，并创建集合等
const adminDb = db.getSiblingDB('admin');

// 创建管理员用户（可选，如果使用 MONGO_INITDB_ROOT_USERNAME/ROOT_PASSWORD 已自动创建）
/*
adminDb.createUser({
  user: "root",
  pwd: "root",
  roles: [
    { role: "root", db: "admin" }
  ]
});
*/

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
