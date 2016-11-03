window managing
closeSpaceWindow: aSpace
	self assert: aSpace hostSpace isNotNil.
	aSpace hostSpace close.
	self spaceManager removeSpace: aSpace.
	