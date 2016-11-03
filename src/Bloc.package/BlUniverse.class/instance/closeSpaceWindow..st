window managing
closeSpaceWindow: aSpace
	self assert: aSpace hostWindow isNotNil.
	aSpace hostWindow close.
	self spaceManager removeSpace: aSpace.
	