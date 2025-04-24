#1. install with source
sudo zypper install git gcc gcc-c++ make bison ncurses ncurses-devel zlib-devel libevent-devel cmake openssl
or yum -y install cmake ncurses ncurses-devel bison 
groupadd mariadb
useradd -s /sbin/nologin -M -g mariadb mariadb
chown -R mariadb:mariadb /data/mysql

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb -DWITH_ARIA_STORAGE_ENGINE=1 -DWITH_XTRADB_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_general_ci -DWITH_READLINE=1 -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1 -DWITHOUT_TOKUDB=1

or 
cmake . -DBUILD_CONFIG=mysql_release && make -j8


make && make install
cp -rf support-files/my-small.cnf /etc/my.cnf
/usr/local/mariadb/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=/usr/local/mariadb --datadir=/data/mysql --user=mariadb
chgrp -R mariadb /usr/local/mariadb/.
#.加入到系统启动中，开机自启动
cp /usr/local/mariadb/support-files/mysql.server /etc/init.d/mariadb
chmod +x /etc/init.d/mariadb
chkconfig --add mariadb
chkconfig mariadb on
#.启动MariaDB
/etc/init.d/mariadb start
or 
/usr/local/mariadb/bin/mysqld_safe --datadir='/data/mysql'

#.设置密码
/usr/local/mariadb/bin/mysqladmin -u root password 123456789


