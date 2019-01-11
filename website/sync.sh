set -x
#set -e
func do_sync() {
LAN=$1
V=$2
echo $LAN $V
for d in `ls versioned_docs/version-$V`;
do
	mkdir -p translated_docs/$LAN/version-$V/$d
done
for f in `cd versioned_docs/version-$V;find . -type f`;
do
	cp translated_docs/$LAN/$f translated_docs/$LAN/version-$V/$f
done 
}
#LAN='zh-CN'
#V="2.1.7"
for L in ja ko
do
for v in 2.1.2 2.1.3 2.1.4 2.1.6 2.1.7
do
do_sync $L $v
done
done 
