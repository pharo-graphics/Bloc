window managing
createSpaceWindow: aSpace
	self assert: aSpace hostWindow isNil.
	self start.
	 self host createWindowFor: aSpace.
	self spaceManager addSpace: aSpace.
	aSpace hostWindow open.
	