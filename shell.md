#1. delete file
find . -name '*_test.go' -delete

#2. delete file
#!/bin/bash
# 循环遍历当前目录下的所有文件，并删除.pyc文件
my_arr = (a b c)
function getfile(){
    for e in `ls $1`
    do  
        fullpath=$1/$e
        if [ -f $fullpath ]; then
            prefix=${fullpath:0-4}
            if [ $prefix == ".pyc" ]; then
                echo delete file:$fullpath
                rm -rf $fullpath
            fi  
        elif [ -d $fullpath ]; then
            getfile $fullpath
        fi  
    done
}
read -p "Are you sure you want to delete all *.pyc files?[Y]:" flag
if [[ ! $flag || "$flag" == "Y" || "$flag" == "y" ]]; then
    getfile .
fi

=========================================
#!/bin/bash
myarr=(a b.pyc csu d.pyc)
function getfile(){
    for e in `ls $1`
    do  
        if [[ ! "${myarr[@]}" =~ "$e" ]]; then
            fullpath=$1/$e
            if [ -f $fullpath ]; then
                prefix=${fullpath:0-4}
                if [ $prefix == ".pyc" ]; then
                    echo delete file:$fullpath
                    rm -rf $fullpath
                fi  
            elif [ -d $fullpath ]; then
                getfile $fullpath
            fi
        fi  
    done
}
read -p "Are you sure you want to delete all *.pyc files?[Y]:" flag
if [[ ! $flag || "$flag" == "Y" || "$flag" == "y" ]]; then
    getfile .
fi

#3. 判断字符串是否在数组中
#!/bin/sh
##数组
array=(
address
base
cart
company
store
)

# $1 如果存在，输出 $1 exists，$1 如果不存在，输出 $1 not exists
if [ "$1" != null ];then
     if [[ "${array[@]}" =~ "${1}" ]]; then
     echo "$1 exists"
     elif [[ ! "${array[@]}" =~ "${1}" ]]; then
     echo "$1 not exists"
     fi
else
     echo "请传入一个参数"
fi

#3. 统计某些文件大小：
KB / 1024(M) / 1024(G)
find . -name "*.webp" -exec du -s {} \; | awk '{sum+=$1};END {print sum / 1024 / 1024}'

#4. 批量替换字符串：
    find -name '.js' | xargs perl -pi -e 's|被替换的字符串|替换后的字符串|g'

    或
    sed -i "s/原字符串/新字符串/g" `grep "原字符串" -rl 所在目录`

#5 tar 压缩排除文件夹
    tar -zcvf demo.tar.gz --exclude=demo/no-need demo
