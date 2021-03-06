#!/bin/bash

#作者：小康
#描述：集群节点间文件或文件夹分发脚本
#微信公众号：小康新鲜事儿

USAGE="使用方法：sh distribution.sh /home/xiaokangxxs.txt or sh distribution.sh /opt/software/hadoop-2.7.7"
if [ $# -ne 1 ];then
        echo $USAGE
        exit 1
fi
#获取需要分发的文件名或者目录名
FDNAME=$(basename $1)
#获取需要分发的文件或目录的上级目录
PDIR=$(cd -P $(dirname $1);pwd)
#获取当前使用系统的用户名
USER=$(whoami)
#需要分发到的节点
NODES=("hadoop02" "hadoop03")
#循环分发
for NODE in ${NODES[*]};do
        echo "--------分发至$NODE--------"
        #如果目标节点的父级目录不存在，则创建出来
        ssh $NODE "
                if [ -d $PDIR ];then
                        . /etc/profile
                else
                        mkdir $PDIR     
                fi"
        rsync -av $PDIR/$FDNAME $USER@$NODE:$PDIR
done
echo "----------------------------------------------------------------------------------------"
echo "--------$PDIR/$FDNAME分发完成!--------"
echo -e "--------微信公众号：\033[5;31m 小康新鲜事儿 \033[0m--------"
echo "--------小康老师微信：k1583223--------"
echo "--------公众号内回复【大数据】，获取系列教程及随堂文档--------"
echo "----------------------------------------------------------------------------------------"