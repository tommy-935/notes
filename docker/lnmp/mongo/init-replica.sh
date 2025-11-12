# 启动后需要手动执行一次初始化副本，后续不用再执行
docker exec -it mongo mongosh -u root -p root --authenticationDatabase admin /docker-entrypoint-initdb.d/init-replica.js
