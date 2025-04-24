#1. macOS系统抓取10分钟内kernel log的详细信息命令：
log show --predicate 'process == "kernel"' --debug --last 10m > ~/Desktop/kernel.log
log show --predicate 'eventMessage contains "lymosdev"' --last 10h --debug
