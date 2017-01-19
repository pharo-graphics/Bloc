displaying
close
	self hostWindowDo: [ :hw | hw primClose. hw primDestroy ].
	renderer := nil.
	hostWindow := nil