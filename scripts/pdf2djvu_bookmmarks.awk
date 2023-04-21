# cat pdf_bookmark.conf | awk -f pdf2djvu_bookmark.awk
BEGIN { RS = "BookmarkBegin"; FS = "\nBookmark(Title|Level|PageNumber):[[:space:]]*"; n=0;
	print "(bookmarks";
}

{
	title[n]=$2
	level[n]=$3
	page[n]=$4
	n++
}

END {
	Level = 0
	for (i=1;i<n;i++)
	{
		if ( i >= 2)
		{
			if ( level[i-1] > level[i] ){
				printf ")\n"	
				Level--
				for (k=level[i-1];k>level[i];k--){
					for (l=1;l<k;l++)
						printf "\t"
					printf ")\n"	
					Level--
				}
			} else if (level[i-1] == level[i] ){
					printf ")\n"	
					Level--
				
			} else
				printf "\n"
		}
		for (j=1;j<=level[i];j++)
			printf "\t"
		printf "(\"%s\"\n", title[i]
		Level++
		for (j=1;j<=level[i];j++)
			printf "\t"
		printf "\"#%d\"", page[i]
#		printf "\"#%d\")\n", page[i]
	}
	print ")"
	Level--
	for (m=0;m<Level;m++){
		for (i=0;i<Level;i++)
			printf "\t"
		print ")"
	}
	print ")"
}
