#set -x
#set -e
function do_sync() {
	LAN=$1
	V=$2
	echo $LAN $V
	for d in `ls versioned_docs/version-$V`;
	do
		mkdir -p translated_docs/$LAN/version-$V/$d
	done
	for f in `cd versioned_docs/version-$V && find . -type f`;
	do
		echo cp translated_docs/$LAN/$f translated_docs/$LAN/version-$V/$f
		cp translated_docs/$LAN/$f translated_docs/$LAN/version-$V/$f
	done 
}
#LAN='zh-CN'
#V="2.1.7"
#for L in ja zh-CN 
for L in zh-CN 
do
	for v in 3.3.1
	do
		do_sync $L $v
	done
done 
