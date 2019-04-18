set -u

last_commit=b6a85d75c9c8077389174a48d0246aefec1bd530
git_root=$(git rev-parse --show-toplevel)

function update_language()
{
	language=$1
	echo update for $language
	head_dir=website/translated_docs/$language
	[[ $language = "en" ]] && head_dir=docs
	if [ ! -d $git_root/$head_dir ]
	then
		echo "invalid language $language $head_dir"
		exit 1
	fi
	updates=`git diff --name-only $last_commit --|grep "^$head_dir"|grep -v version|grep "md$"`
	for item in $updates
	do
		doc_name=`echo $item|sed "s#$head_dir/##"`
		if [ "$language" == "en" ]
		then
			#cd $git_root/$head_dir
			#git diff --no-color --no-prefix --relative=$head_dir $last_commit HEAD $doc_name > $tmpfile 
			#patch -p0 < $tmpfile
			cd $git_root/website/versioned_docs
			version=`find version* |grep $doc_name|sort|tail -n 1|cut -d/ -f1`
			echo update $doc_name at version $version 
			cd $version
			tmpfile=/tmp/lispczz_`basename $doc_name`
			head -n 6 $doc_name > $tmpfile
			tail -n +6 $git_root/$head_dir/$doc_name >> $tmpfile
			cp $tmpfile $doc_name
		else
			cd $git_root/$head_dir 
			version=`find version* |grep $doc_name|sort|tail -n 1|cut -d/ -f1`
			echo update $doc_name at version $version 
			cp $doc_name $version/$doc_name
		fi
	done
}

update_language en
update_language zh-CN
#update_language ja
