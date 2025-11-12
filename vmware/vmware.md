1. 解决不会自动挂载共享folder的问题
    sudo nano /etc/fstab
    在最后添加一行：
    .host:/www /mnt/hgfs/www fuse.vmhgfs-fuse allow_other,default 0 0
    或者手动执行： 
    sudo vmhgfs-fuse .host:/www /mnt/hgfs/www -o allow_other
2. 