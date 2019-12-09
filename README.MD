This is a shell usecase of [ImageMagick](https://github.com/ImageMagick/ImageMagick)

# What it can do?
It can batch compress pictures. compress to how many size depends on you. 

# How to use?
the only you should do is put your images to img folder, and run squash.bat
of couse, squash.bat is prepare for window.

the squash.sh is prepare for linux. and it needn't depends on ImageMagick-7.0.8* folder.

# Sample
```bash
find ./ -regex '.*\(jpg\|JPG\|png\|jpeg\)' -exec convert -resize 600x800 {} {} \; #处理当前文件中所有指定图片文件, 全部压缩至600*800像素
```
