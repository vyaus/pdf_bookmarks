#!/usr/bin/env awk -f

BEGIN {
    FS = "\t"  # 设置字段分隔符为制表符
}

{
    # 按照指定顺序输出每个书签的多行结构
    print "BookmarkBegin"
    print "BookmarkTitle: " $2
    print "BookmarkLevel: " $3
    print "BookmarkPageNumber: " $1
}