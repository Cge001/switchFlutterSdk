
set -o errexit

clear
echo "\033[42;38m$(date +%Y-%m-%d\ %H:%M:%S) 切换Flutter SDk 开始... \033[0m"

# just test
# currentVersion4=1.22.6
# filenames=$(ls)
# checkNewName=0
# for file in ${filenames}; do
# 	echo "file = $file"
# 	if [ $file == flutter_${currentVersion4} ];then
# 		echo "$file == flutter_${currentVersion4}"
# 		checkNewName=1
# 	fi
# done
# if [ $checkNewName -eq 1 ]
# then
# 	echo "okkkkkk"
# else	
# 	echo "noooo... $checkNewName"
# 	errexit
# fi


# just test
# filenames=$(ls)
# currentVersion4="1.22.6"
# checkNewName=0
# checkFlutterName=0
# checktOldName=0
# chooseVersionName="flutter_1.12.13+hotfix.9"
# for file in ${filenames}; do
# 	if [ $file == flutter_${currentVersion4} ];then
# 		echo "$file == flutter_${currentVersion4}"
# 		checkNewName=1
# 	fi

# 	if [ $file == flutter ];then
# 		echo "$file == flutter"
# 		checkFlutterName=1
# 	fi

# 	if [ $file != ${chooseVersionName} ];then
# 		echo "$file != ${chooseVersionName}"
# 		checktOldName=1
# 	fi
# done


# #check sth
# echo "checkNewName = $checkNewName"
# echo "checkFlutterName = $checkFlutterName"
# echo "checktOldName = $checktOldName"
# echo "=================="
# errexit


# sudo mv ./testProject ./testPrjectzz

# 获取当前Flutter SDK版本
currentVersion=$(flutter --version)
# echo "test1 $currentVersion"

currentVersion2="${currentVersion%%•*}"
# echo "test2 ${currentVersion2}"

currentVersion3="${currentVersion2}"
# echo "test3 ${currentVersion3##*Flutter }"

currentVersion4="${currentVersion3##*Flutter }"

echo "当前flutter版本：\033[47;31m $currentVersion4\033[0m"


# 进入多个flutter sdk所在的目录，每个人的不一样
# cd /Users/mac/workSpace/16_switchSDK

filenames=$(ls)

echo "可供切换的sdk版本:"
a=1
for file in ${filenames}; do
	# 找到以flutter_开头的文件名
	if [[ $file == flutter_* ]];then 
		echo "		【 $a 】$file"
		((a++))
	fi
done

read -p "选择要切换的版本（输入数字1、2、3）：" versionIndex

# flutter sdk 版本的个数
flutterSDKCount=`expr $a - 1`


if [[ "$versionIndex" =~ ^[1-${flutterSDKCount}]+$ ]]; then  
echo "输入的数字是$versionIndex"
else  
echo "\033[47;31mERROR: 大哥，别瞎搞...最大数字是${flutterSDKCount},你给我来个${versionIndex}...\033[0m"
errexit
fi

chooseVersionName=""
b=1
for file in ${filenames}; do
	if [[ $file == flutter_* ]];then
		if [ $b -eq ${versionIndex} ]
		then
    		chooseVersionName="${file}"
		fi
		((b++))
	fi
done

echo "开始切换:\033[47;31m ${chooseVersionName} ...... \033[0m"

# 先将flutter文件夹改为当前版本
	# 如flutter --> flutter_1.12.13+hotfix9
sudo mv flutter flutter_${currentVersion4}

# 再将用户选择切换的版本对应的文件夹重命名为flutter
	# 如flutter_1.22.6 --> flutter
sudo mv ${chooseVersionName} flutter

# 重启Android Stuido


# echo ”currentVersion4 = flutter_${currentVersion4}“

#校验是否重命名成功，同时等待更名的过程不至于那么早的输出成功
checkNewName=0
checkFlutterName=0
checktOldName=0
# 重置filenames，因为中间经过了重命名
filenames=$(ls)
for file in ${filenames}; do

	# echo "file ===== $file"

	if [ $file == flutter_${currentVersion4} ];then
		# echo "${file}1 == flutter_${currentVersion4}"
		checkNewName=1
	fi

	if [ $file == flutter ];then
		# echo "${file}2 == flutter"
		checkFlutterName=1
	fi

	if [ $file != ${chooseVersionName} ];then
		# echo "${file}3 != ${chooseVersionName}"
		checktOldName=1
	fi
done


#check sth
# echo "checkNewName = $checkNewName"
# echo "checkFlutterName = $checkFlutterName"
# echo "checktOldName = $checktOldName"


if [ $checkNewName -eq 1 ] && [ $checkFlutterName -eq 1 ] && [ $checktOldName -eq 1 ]
then
	echo "\033[42;38m$(date +%Y-%m-%d\ %H:%M:%S) 切换Flutter SDk 完成.  \033[0m"

	# 获取当前Flutter SDK版本
	currentVersionNew=$(flutter --version)
	# echo "test1 $currentVersion"
	#当前flutter sdk版本为：
	echo "当前flutter版本：\033[47;31m $currentVersionNew \033[0m"	
else 
	echo "\033[47;31mERROR: 大哥，失败了... \033[0m"
	errexit
fi



