#1. install with binary in linux
$> groupadd mysql
$> useradd -r -g mysql -s /bin/false mysql
$> cd /usr/local
$> tar xvf /path/to/mysql-VERSION-OS.tar.xz
$> ln -s full-path-to-mysql-VERSION-OS mysql
$> cd mysql
$> mkdir mysql-files
$> chown mysql:mysql mysql-files
$> chmod 750 mysql-files
$> bin/mysqld --initialize --user=mysql
$> bin/mysql_ssl_rsa_setup
$> bin/mysqld_safe --user=mysql &
# Next command is optional
$> cp support-files/mysql.server /etc/init.d/mysql.server

#2. binlog show command
mysqlbinlog --base64-output=decode-rows -vv binlog.000001 > log1

#3. drop table by prefix
SET group_concat_max_len = 20000;
select concat("drop table ", GROUP_CONCAT(table_name), ";") as sql1 from information_schema.tables where table_name like "wp_%";  
select concat("drop table ", table_name, ";") as sql1 from information_schema.tables where table_name like "%_wp_%";

#4. create user
create database woo3 default character set utf8mb4 collate utf8mb4_unicode_ci;
create user 'web092722'@'localhost' identified by 'seu.wsu1ds39-Smx#s-6Ds';
grant select,update,insert,delete on woo3.* to 'web092722'@'localhost';
flush privileges;

#5. mysqld conf
sql_mode = STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION

#6. backup
mysqldump -hhostname -uusername -pmypwd databasename > /path to backup/bakname.sql

#7. import settings
	set global max_allowed_packet = 2*1024*1024*10   or max_allowed_packet = 20M in my.cnf
	set global net_read_timeout = 120;
	set global net_write_timeout = 900;

	如果表损坏：innodb_force_recovery = 1 或者 6
	innodb_large_prefix=ON 使用索引超过767字节

#8. install on windows of mysql version 8.1.0+
	1. write a conf file: ./my.cnf :
		[mysqld]
		basedir=D:\web-server\mysql-8.1.0-winx64
		datadir=D:\web-server\mysql-8.1.0-winx64\data-mysql
		port=3307

	2. init data
		./bin/mysqld.exe --defaults-file={dir}/my.cnf --initialize
		./bin/mysqld.exe --defaults-file={dir}/my.cnf --initialize-insecure

	3. start server
		./bin/mysqld.exe --defaults-file={dir}/my.cnf --console

	4. change password for root first time:
		ALTER USER 'root'@'localhost' IDENTIFIED BY 'root-password';

	5. install as service 
		./bin/mysqld.exe --install MySQL --defaults-file={dir}/my.cnf

	6. remove service 
		./bin/mysqld.exe --remove


#9. mysql表分区
	#已有表创建分区
	alter table wp_postmeta partition by key(meta_id) partitions 10;

	#删除指定分区
	alert table tb_user DROP PARTITION p1;

	#删除所有分区
	alter table tb_user REMOVE PARTITIONING;

	#查看分区信息
	show create table tb_user;
	SHOW PARTITIONS;









