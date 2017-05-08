instance creation
checker: aPoint
	<return: #SpartaCanvas>

	^ (self class environment at: #MozCanvas) checker: aPoint