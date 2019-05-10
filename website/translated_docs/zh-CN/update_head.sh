mds=`find . -name '*md' |grep -v 'version'`
for md in $mds
do
	versioned=`find . -name '*md'|grep version|sort -r|grep $md|head -n 1`
	cp $md $versioned
done
