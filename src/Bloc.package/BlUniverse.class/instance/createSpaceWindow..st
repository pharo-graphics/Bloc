window managing
createSpaceWindow: aSpace
	self assert: aSpace hostSpace isNil.
	self start.
	self host createHostSpaceFor: aSpace.
	self spaceManager addSpace: aSpace.
	aSpace hostSpace open.
	