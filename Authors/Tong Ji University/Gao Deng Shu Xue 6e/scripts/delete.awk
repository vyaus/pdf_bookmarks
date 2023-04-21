BEGIN { RS = "\nBookmarkBegin\n";
#	FS = "\nBookmark(Title|Level|PageNumber):[[:space:]]*";
}

{
#	if ( $0 ~ /第.*章/ ){	
#		title[n]=$2
#	}
	if ( $0 !~ /习题答案与提示/ ){	
		print "BookmarkBegin"
		print $0
	}
}
