#!/bin/bash
echo "default apache directory has been set to /home/html in my case
echo "all fake video files will be created under /home/html/mov/ directory
echo "variable defitinition starts here:"
mkdir /home/html/mov
cd /home/html/mov
directory='test' #create a directory named test or whatsoever you wish
mkdir test #you can change directory name as you wish in this line.
input='sample.m3u' #your input m3u filename
echo "my test.m3u file format is like EXTINF:-1, if yours is different, edit "15th line" before running this script.
url='example.com:8888' #url with port & without http://
username='bombolini' #assigned username comes here
password='kodi' #assigned password
dbname='mariadb' #change db name in compatible with your sql table
grep -A0 "EXTINF" $input > 1
sed -i "s|#EXTINF:-1,||g" 1
sed -i "s|\!||g" 1
sed -i "s|\&| And |g" 1
sed -i "s|'||g" 1
sed -i "s|\?||g" 1
sed -i "s|\/|\.|g" 1
grep -A0 "http" $input > 2
sed -i '/--/d' 1
sed -i '/--/d' 2
sed -i "s| |\.|g" 1
sed -i "s|http://$url/movie/$username/$password/||g" 2
paste -d '\t' 1 2 > 3
sed -i "s|\t.*\.mkv|\.mkv|g" 3
sed -i "s|\t.*\.mp4|\.mp4|g" 3
sed -i "s|\t.*\.avi|\.avi|g" 3
sed -i "s|\.\.avi|\.avi|g" 3
sed -i "s|\.\.mkv|\.mkv|g" 3
sed -i "s|\.\.mp4|\.mp4|g" 3
while read -r line
do
cp sample.mp4 $line
done<3
while read -r line
do
echo "'http:\\\\\/\\\\\/$url\\\\\/movie\\\\\/$username\\\\\/$password\\\\\/$line');"
done <2 > 22
while read -r line
do
echo "update streams set stream_source = replace ( stream_source, 's:1:\\\\\/home\\\\\/html\\\\\/mov\\\\\/$directory\\\\\/$line', "
done<3 > 33
paste 33 22 > 44
sed -i "s|\t| |g" 44
sed -i '1iuse mariadb;\' 44
rm 33 22 3 2 1
echo "all done"
sleep 2
echo "to inject new files into your sql, run below command"
sleep 2
echo "mysql < 44"
sleep 2
exit 0
