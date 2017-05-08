instance creation
checker: aPoint
	<return: #SpartaCanvas>
	
	^ (self class environment at: #SpartaCairoCanvas) checker: aPoint