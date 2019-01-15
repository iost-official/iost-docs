set -u
root=$(git rev-parse --show-toplevel)
here=$(realpath --relative-to=$root $(pwd))
updates=`git diff --name-only HEAD^ HEAD|grep $here|grep -v version|grep "md$"`
for item in $updates
do
	f=$(export here_abs=`pwd`;cd $root;realpath --relative-to=$here_abs `realpath $item`)
	echo update $f
	#tmpfile=/tmp/lispczz_`basename $f`
	#git diff --no-color --no-prefix --relative=website/translated_docs/ja  HEAD^ HEAD $f > $tmpfile 
        version=`find version* |grep $f|sort|tail -n 1|cut -d/ -f1`
	echo update at version $version 
	cp $f $version/$f
        #(cd $version;patch -p0 < $tmpfile)
done
