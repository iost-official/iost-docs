for item in `find . -name '*md'|grep 'version-'|sort`;
do
	from=$item
	to=`echo $from|gsed 's#./[^/]\+/##'`
	echo $from to $to
	cp $from $to
done
find . -name '*md' | gsed -n '/\.\/[1-9]/p' |xargs -L1 gsed -i 's#id: version-[0-9].[0-9].[0-9]-#id: #'
find . -name '*md' | gsed -n '/\.\/[1-9]/p' |xargs -L1 gsed -i '/original_id:/d'
