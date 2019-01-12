exp=""
# "/#" -> "#"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(]\+\)\/#/\1\2#/g;'
# "#" -> ".md#"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(]\+\)#/\1\2.md#/g;'
# "/)" -> ")"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(#]\+\)\/)/\1\2)/g;'
# ")" -> ".md)"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(#]\+\))/\1\2.md)/g;'
# "(http|assets)...md" -> "http..."
exp+='s/\(\(http\|assets\)[^\n)]\+\).md/\1/g;'
# "../" -> ""
exp+='s#(../\([0-9]\)#(\1#g;'
# ".md.md" -> ".md"
exp+='s#.md.md#.md#g;'

#find docs website/translated_docs/zh-CN -type f -name '*md' |grep '^website/translated_docs/zh-CN/\d\|^docs/\d' | xargs -L1 gsed -i "$exp" 
find website/translated_docs/ja -type f -name '*md' |grep -v markdown-example.md | grep -v '^website/translated_docs/ja/\d' | xargs -L1 gsed -i "$exp" 
