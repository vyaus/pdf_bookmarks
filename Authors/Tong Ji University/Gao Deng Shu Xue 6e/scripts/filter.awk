BEGIN { RS = "\nBookmarkBegin";
	FS = "\nBookmark(Title|Level|PageNumber):[[:space:]]*";
	n=0;
}

{
	if ( $0 ~ /第.*章/ ){	
		title[n]=$2
	}
	if ( $0 ~ /习题答案与提示/ ){	
		level[n]=$3
		page[n]=$4
		n++
	}
}

END {
	for (i=0;i<n;i++){
		print "BookmarkBegin"
		print "BookmarkTitle:" title[i]
		print "BookmarkLevel:" level[i]
		print "BookmarkPageNumber:" page[i]
		}

}
