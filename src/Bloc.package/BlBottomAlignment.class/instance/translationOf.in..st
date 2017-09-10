translation
translationOf: aBounds in: aContainerBounds
	<return: #Point>
	
	^ 0 @ (aContainerBounds height - aBounds height + aContainerBounds top - aBounds top)