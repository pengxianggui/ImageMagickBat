#!/bin/bash

imgdir=img

function resize() {
	for picfile in `find ${imgdir} -regex '.*\(jpg\|JPG\|png\|jpeg\)' -size +${maxSize}`
	do
		#convert -resize 80%x80% {} {} \;
		convert ${picfile} -resize 95%x95% ${picfile}
	done
}

# 判断是否需要安装ImageMagick
command -v convert > /dev/null 2>&1 || {
	echo >&2 "没有安装ImageMagick, 开始安装，确保联网..."
	sudo apt install imagemagick
}

read -p "请输入需要压缩至多大以下？请别少于1k(如果是kb,则单位为k， 如果是mb,则单位为M),如: 200k 或者 1M: " maxSize

echo "在开始压缩前，再次确认你输入的参数没有问题:"
echo "你指定需要将${imgdir}下所有图片压缩的到${maxSize}以下？"

read -p "请确认上面无误[y/n]: " -n 1 confirm
echo '\n'
echo "confirm: ${confirm}"

if [[ ${confirm} != y ]]; then
	echo "即将退出，不会执行压缩.."
	sleep 2s
	exit 1
fi

echo "你选择了确认, 开始扫描目录${imgdir}.."
sleep 2s

# 只要还存在大于${maxSize}大小的图片，则循环压缩至80%，直到没有满足此条件的图片
size=`find ${imgdir} -regex '.*\(jpg\|JPG\|png\|jpeg\)' -size +${maxSize}|wc -l`
echo "大于${maxSize}的图片数量有${size}个."
while [[ ${size} -ne 0 ]]
do
	echo "开始进行压缩处理.."
	resize
	echo "压缩处理完毕.."
	size=`find ${imgdir} -regex '.*\(jpg\|JPG\|png\|jpeg\)' -size +${maxSize}|wc -l`
	echo "大于${maxSize}的图片还剩余${size}个"
done

echo "压缩执行结束, 即将退出..."
sleep 2s
exit 0
