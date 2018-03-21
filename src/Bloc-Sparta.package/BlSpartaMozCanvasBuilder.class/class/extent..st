api - instance creation
extent: aPoint
	<return: #SpartaCanvas>

	^ (self class environment at: #MozCanvas) extent: aPoint