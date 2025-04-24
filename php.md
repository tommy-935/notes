<<<<<<< HEAD
#1. install php
./configure --prefix=/usr/local/php --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-openssl --with-zlib --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-xpm --with-freetype --enable-intl --enable-mbstring --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql --with-zip

or 

./configure --prefix=/usr/local/php --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-openssl --with-zlib --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-xpm --with-freetype --enable-intl --enable-mbstring --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql --with-zip --with-apxs2=/usr/local/apache/bin/apxs


or Mac php-8.2

./configure --prefix=/Volumes/app/opt/lnmp/php --with-config-file-path=/Volumes/app/opt/lnmp/php/etc --with-iconv=/usr/local/opt/libiconv --with-freetype --with-jpeg --with-zlib --enable-xml --with-curl --enable-fpm --enable-mbstring --enable-gd --enable-bcmath --with-openssl-dir=/Volumes/app/opt/openssl --with-openssl --with-zip --with-zlib --enable-pdo --with-pdo-mysql=/Volumes/app/opt/lnmp/mysql --with-mysqli


#2. composer usage
	composer install 
	composer update mypackage/mypackage
	composer require package
	composer search package
	composer init  ==== create your package

#3. install composer
	php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	sudo mv composer.phar /usr/local/bin/composer  === linux
	@php "%~dp0composer.phar" %*  === in composer.bat on php bin path of windows

#4. yum 升级php
	# yum list installed | grep php
# yum remove php
# yum remove php-*
# yum remove php72*
# yum list installed | grep php
# yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
# yum install -y php74-php-fpm php74-php-cli php74-php-bcmath php74-php-gd php74-php-json php74-php-mbstring php74-php-mcrypt php74-php-mysqlnd php74-php-opcache php74-php-pdo php74-php-pecl-crypto php74-php-pecl-mcrypt php74-php-pecl-geoip php74-php-recode php74-php-snmp php74-php-soap
# ln -s /usr/bin/php74 /usr/bin/php
# systemctl enable php74-php-fpm
# systemctl start php74-php-fpm 

#5. 

=======
#1. install php
./configure --prefix=/usr/local/php --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-openssl --with-zlib --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-xpm --with-freetype --enable-intl --enable-mbstring --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql --with-zip

or 

./configure --prefix=/usr/local/php --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-openssl --with-zlib --with-curl --enable-ftp --enable-gd --with-webp --with-jpeg --with-xpm --with-freetype --enable-intl --enable-mbstring --with-mysqli=/usr/local/mysql/bin/mysql_config --with-pdo-mysql=/usr/local/mysql --with-zip --with-apxs2=/usr/local/apache/bin/apxs

#2. composer usage
	composer install 
	composer update mypackage/mypackage
	composer require package
	composer search package
	composer init  ==== create your package

#3. install composer
	php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	sudo mv composer.phar /usr/local/bin/composer  === linux
	@php "%~dp0composer.phar" %*  === in composer.bat on php bin path of windows

>>>>>>> 32810b1222c5c036c41318097dbc689eefc4c754
