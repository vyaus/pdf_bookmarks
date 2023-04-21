BEGIN { RS = "\nBookmarkBegin";
}

{
	if ($0 ~ /Title: Worldview[s]* /)
	{
		printf "BookmarkBegin"
		print $0 
	}
}

