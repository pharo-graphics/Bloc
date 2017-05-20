*Bloc-Sparta
pathOnSpartaCanvas: aCanvas inBounds: aBounds
	self checkSession.
	^ self owner geometry buildPathOnSpartaCanvas: aCanvas within: aBounds