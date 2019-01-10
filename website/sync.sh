set -x
set -e
LAN='zh-CN'
V="2.1.6"
for d in `ls versioned_docs/version-$V`;
do
	mkdir -p translated_docs/zh-CN/version-$V/$d
done
for f in `cd versioned_docs/version-$V;find . -type f`;
do
	cp translated_docs/zh-CN/$f translated_docs/zh-CN/version-$V/$f
done 
