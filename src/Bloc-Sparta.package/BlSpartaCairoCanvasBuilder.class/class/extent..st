api - instance creation
extent: aPoint
	<return: #SpartaCanvas>
	
	^ (self class environment at: #SpartaCairoCanvas) extent: aPoint