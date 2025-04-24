#1. atop tool 
    yum install atop

    vi /etc/sysconfig/atop 
    LOGOPTS=""
    LOGINTERVAL=60  # 60s once
    LOGGENERATIONS=7 # 7days log
    LOGPATH=/var/log/atop

#2. free -m 
    cd /usr
    mkdir swap
    dd if=/dev/zero of=/usr/swap/swapfile bs=1M count=1024
    mkswap /usr/swap/swapfile
    swapon /usr/swap/swapfile

    set reboot on start:
    vim /etc/fstab
    /usr/swap/swapfile swap swap defaults 0 0

    delete:
    delete /etc/fstab : /usr/swap/swapfile swap swap defaults 0 0
    swapoff /usr/swap/swapfile
    rm -rf /usr/swap/swapfile
    
#3. 查看服务器型号
    dmidecode -t1

#4. 查看centos版本
    cat /etc/redhat-release

#5. 
