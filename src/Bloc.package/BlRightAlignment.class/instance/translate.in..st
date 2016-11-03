translation
translate: aBounds in: aContainerBounds
	<return: #Point>
	
	^ (aContainerBounds width - aBounds width + aContainerBounds left - aBounds left) @ 0