# 生成本地ssl证书方法：

方法一：
生成根证书：
私钥：openssl genrsa -des3 -out rootca.key 2048
根证书：openssl req -new -x509 -days 3650 -key rootca.key -out rootca.crt

生成二级根证书：
私钥：openssl genrsa -des3 -out secondca.key 2048
去密码：openssl rsa -in secondca.key -out secondCA.key
请求文件：openssl req -new -days 3650 -key secondca.key -out secondca.csr
根证书签名：openssl ca -extensions v3_ca -in secondca.csr -config /etc/ssl/openssl.cnf -days 3650 -out secondca.crt -cert rootca.crt -keyfile rootca.key

生成服务端证书：
私钥：openssl genrsa -des3 -out server.key 2048
去密码：openssl rsa -in server.key -out server.key
请求文件：openssl req -new -days 3650 -key server.key -out server.csr
签名：openssl ca -in server.csr -config /etc/ssl/openssl.cnf -days 3650 -out server.crt -cert secondca.crt -keyfile secondca.key

生成钥匙链：
钥匙链：cat rootca.crt secondca.crt > chain.crt

sudo openssl genrsa -des3 -out server.key 2048
sudo openssl req -new -key server.key -out server.csr
sudo openssl x509 -req -days 30 -in server.csr -signkey server.key -out server.crt


方法二：
或者更简单一句命令：
	sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
之后配置apahce.conf即可:
	SSLEngine on
   	SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   	SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

方法三：
openssl genrsa -des3 -passout pass:123456 -out ssl.pass.key 2048
openssl rsa -passin pass:123456 -in ssl.pass.key -out ssl.key
openssl req -new -key ssl.key -out ssl.csr
openssl x509 -req -days 365 -in ssl.csr -signkey ssl.key -out ssl.crt