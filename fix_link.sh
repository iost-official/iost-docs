exp=""
# "/#" -> "#"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(]\+\)\/#/\1\2#/g;'
# "#" -> ".md#"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(]\+\)#/\1\2.md#/g;'
# "/)" -> ")"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(#]\+\)\/)/\1\2)/g;'
# ")" -> ".md)"
exp+='s/\(\[[^\n\[]\+\]\)\(([^\n(#]\+\))/\1\2.md)/g;'
# (http|assets)...md -> http...
exp+='s/\(\(http\|assets\)[^\n)]\+\).md/\1/g;'

find docs website/translated_docs/zh-CN -type f -name '*md' |grep '^website/translated_docs/zh-CN/\d\|^docs/\d' | xargs -L1 gsed -i "$exp" 
