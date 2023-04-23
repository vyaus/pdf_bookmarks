BEGIN { FS = "\t";
	n=0;
}

{
	if ( NF > 1 ) {
		record[n]=1
		title[n]=$1
		page[n]=$2
		if ( $3 ) {
			level[n]=$3
		}else{
			level[n]=2
		}
		n++
	} else {
		record[n]=false
		n++
	}
}

END {
	for (i=0;i<n;i++){
		if ( record[i] ) {
			print "BookmarkBegin"
			print "BookmarkTitle: " title[i]
			print "BookmarkLevel: " level[i]
			print "BookmarkPageNumber: " page[i]
		}else {
			print "\n"
		}
	}
}
