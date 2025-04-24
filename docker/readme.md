<<<<<<< HEAD
docker run --name local-nginx -v e:/docker/lnmp/www:/usr/share/nginx/html -p 80:80 -d nginx

=====  docker run -p 9000:9000 --name local-php  -v e:/docker/lnmp/php-log:/usr/local/var/log -v e:docker/lnmp/www:/usr/share/nginx/html:ro -itd php:7.2-fpm

docker run -p 9000:9000 --name local-php  -v e:/docker/lnmp/php-log:/usr/local/var/log -itd php:7.2-fpm

docker run -itd --name local-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.7

复制配置文件到本地：
docker cp local-php:/usr/local/etc e:/lnmp/php/conf
docker cp local-php:/usr/local/var/log e:/lnmp/php/logs
docker cp local-nginx:/etc/nginx/conf e:/lnmp/nginx/conf


php + mysql：
docker run --name php-mysql -p 9002:9000 -v e:/docker/lnmp/www:/usr/share/nginx/html -v -v e:/docker/lnmp/php-log:/usr/local/var/log --link local-mysql:mysql:5.7  -itd php:7.2-fpm

php + nginx
docker run --name php-nginx -p 82:80 -d -v e:/docker/lnmp/www:/usr/share/nginx/html:ro -v e:/docker/lnmp/nginx/conf/conf.d:/etc/nginx/conf.d -v e:/docker/lnmp/nginx/logs:/var/log/nginx --link php-mysql:php -d nginx 


docker cp lnmp:/usr/local/nginx/conf e:/lnmp/nginx/conf




docker run -dit \
-p 80:80 \
-p 443:443 \
-p 3306:3306 \
-p 9000:9000 \
-v e:/docker/lnmp/www:/www \
-v e:/docker/lnmp/mysql:/data/mysql \
--privileged=true \
--name=lnmp \
2233466866/lnmp


docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/mysql:/data/mysql -v e:/docker/lnmp/cnf/my.cnf:/etc/my.cnf -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf --privileged=true --name=lnmp 2233466866/lnmp



docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf -v e:/docker/lnmp/mysql:/data/mysql --privileged=true --name=lnmp 2233466866/lnmp

docker run -dit --privileged --name=lnmp 2233466866/lnmp

docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf --privileged=true --name=dlnmp duckll/lnmp


=======
docker run --name local-nginx -v e:/docker/lnmp/www:/usr/share/nginx/html -p 80:80 -d nginx

=====  docker run -p 9000:9000 --name local-php  -v e:/docker/lnmp/php-log:/usr/local/var/log -v e:docker/lnmp/www:/usr/share/nginx/html:ro -itd php:7.2-fpm

docker run -p 9000:9000 --name local-php  -v e:/docker/lnmp/php-log:/usr/local/var/log -itd php:7.2-fpm

docker run -itd --name local-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.7

复制配置文件到本地：
docker cp local-php:/usr/local/etc e:/lnmp/php/conf
docker cp local-php:/usr/local/var/log e:/lnmp/php/logs
docker cp local-nginx:/etc/nginx/conf e:/lnmp/nginx/conf


php + mysql：
docker run --name php-mysql -p 9002:9000 -v e:/docker/lnmp/www:/usr/share/nginx/html -v -v e:/docker/lnmp/php-log:/usr/local/var/log --link local-mysql:mysql:5.7  -itd php:7.2-fpm

php + nginx
docker run --name php-nginx -p 82:80 -d -v e:/docker/lnmp/www:/usr/share/nginx/html:ro -v e:/docker/lnmp/nginx/conf/conf.d:/etc/nginx/conf.d -v e:/docker/lnmp/nginx/logs:/var/log/nginx --link php-mysql:php -d nginx 


docker cp lnmp:/usr/local/nginx/conf e:/lnmp/nginx/conf




docker run -dit \
-p 80:80 \
-p 443:443 \
-p 3306:3306 \
-p 9000:9000 \
-v e:/docker/lnmp/www:/www \
-v e:/docker/lnmp/mysql:/data/mysql \
--privileged=true \
--name=lnmp \
2233466866/lnmp


docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/mysql:/data/mysql -v e:/docker/lnmp/cnf/my.cnf:/etc/my.cnf -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf --privileged=true --name=lnmp 2233466866/lnmp



docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf --privileged=true --name=lnmp 2233466866/lnmp

docker run -dit --privileged --name=lnmp 2233466866/lnmp

docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf --privileged=true --name=dlnmp duckll/lnmp


>>>>>>> f22d63ed2e0e665a8af51f9eb6c533375165587d
docker run -itd -p 80:80 -p 443:443 -p 3306:3306 -p 9000:9000 -v e:/www:/www -v e:/docker/lnmp/nginx/conf:/usr/local/nginx/conf --privileged=true --name=flnmp fbraz3/lnmp