set -u
set -e

last_commit=b10f95b142cc64bd1612cb0718af5a214d312a27
git_root=$(git rev-parse --show-toplevel)

function update_language()
{
	language=$1
	head_dir=website/translated_docs/$language
	[[ $language = "en" ]] && head_dir=docs
	if [ ! -d $git_root/$head_dir ]
	then
		echo "invalid language $language $head_dir"
		exit 1
	fi
	updates=`git diff --name-only $last_commit HEAD|grep "^$head_dir"|grep -v version|grep "md$"`
	echo $updates
	for item in $updates
	do
		doc_name=`echo $item|gsed "s#$head_dir/##"`
		echo update $doc_name
		if [ "$language" == "en" ]
		then
			cd $git_root/website/versioned_docs
			version=`find version* |grep $doc_name|sort|tail -n 1|cut -d/ -f1`
			tmpfile=/tmp/lispczz_`basename $doc_name`
			git diff --no-color --no-prefix --relative=$head_dir $last_commit HEAD $doc_name > $tmpfile 
			#echo update at version $version 
			cd $version
			patch -p0 < $tmpfile
		else
			cd $git_root/$head_dir 
			version=`find version* |grep $doc_name|sort|tail -n 1|cut -d/ -f1`
			cp $f $version/$f
		fi
	done
}

update_language zh-CN
update_language en
