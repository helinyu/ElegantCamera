#!/bin/sh

#  Script.sh
#  KKStarZone
#
#  Created by kankanliu on 16/2/1.
#  Copyright © 2016年 kankan. All rights reserved.

#  更新代码

#切换环境
#su - Fluman <"123"

#工程绝对路径
#cd $1
current_date=$(date "+%Y_%m_%d_%H:%M:%S")
#project_path=/Users/fluman/Desktop/Pro/Git/ios_asmh_fix_v2.0.8

scirpt_path=$(cd "$(dirname "$0")";pwd)
project_path=${scirpt_path}

cd $project_path
#build文件夹路径
build_path=${project_path}/build

#工程配置文件路径
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
project_infoplist_path=${project_path}/${project_name}/${project_name}-Info.plist
#取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${project_infoplist_path})
#取build值
bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" ${project_infoplist_path})
#取bundle Identifier前缀
bundlePrefix=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" `find . -name "*-Info.plist"` | awk -F$ '{print $1}')


cd $project_path
echo clean start ...
#删除bulid目录
if  [ -d ${build_path} ];then
rm -rf ${build_path}
echo clean build_path success.
fi
#清理工程
tmp_project_dst_file=/tmp/${project_name}.dst
echo "lt - $tmp_project_dst_file"

if [ -d ${tmp_project_dst_file} ]; then 
 rm -rf ${tmp_project_dst_file}
fi

xcodebuild clean || exit
#去掉xcode源码末尾的空格
#find . -name "*.[hm]" | xargs sed -Ee 's/ +$//g' -i ""

#编译工程 iphone
xcodebuild  -configuration Release  -workspace ${project_path}/${project_name}.xcodeproj/project.xcworkspace \
-scheme ${project_name} \
ONLY_ACTIVE_ARCH=NO \
TARGETED_DEVICE_FAMILY=1 \
DEPLOYMENT_LOCATION=YES CONFIGURATION_BUILD_DIR=${project_path}/build/Release-iphoneos  || exit

# ipad的内容
#xcodebuild  -configuration Release  -workspace *.xcwork* \
#-scheme ${project_name} \
#ONLY_ACTIVE_ARCH=NO \
#TARGETED_DEVICE_FAMILY="1,2" \
#DEPLOYMENT_LOCATION=YES CONFIGURATION_BUILD_DIR=${project_path}/build/Release-iphoneos  || exit

#xcodebuild -workspace *.xcwork* -scheme ${project_name} -configuration ${build_config} CONFIGURATION_BUILD_DIR=${compiled_path} ONLY_ACTIVE_ARCH=NO || exit

if [ -d ./ipa-build ];then
rm -rf ipa-build
fi
#打包
#zip_name=${project_name}"_"${current_date}
zip_name=${project_name}
cd $build_path
mkdir -p ipa-build/Payload
cp -r ./Release-iphoneos/*.app ./ipa-build/Payload/
cd ipa-build
zip -r ${zip_name}.ipa *

echo ${build_path}/ipa-build/${zip_name}.ipa
#找到桌面路径
mkdir -p ~/Desktop/ipa_release
cd ~/Desktop/ipa_release
dir_name=${project_name}$(date "+_relase-%Y-%m-%d-%H-%M-%S")
mkdir -p ${dir_name}
cd ~/Desktop/ipa_release/${dir_name}

#echo Desktop dir
#echo $(pwd)
#拷贝文件

cp -r ${build_path}/ipa-build/${zip_name}.ipa  $(pwd)
#清空bulid目录
cd ${build_path}/ipa-build
rm -rf Payload
if  [ -d ${build_path} ];then
rm -rf ${build_path}
fi

#拷贝到共享目录
#dir_name="StarZone"$(date "+%Y-%m-%d-%H-%M-%S")
