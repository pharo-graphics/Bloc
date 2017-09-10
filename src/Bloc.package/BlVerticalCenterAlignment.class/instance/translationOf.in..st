translation
translationOf: aBounds in: aContainerBounds
	<return: #Point>
	
	^ 0 @ ((aContainerBounds height - aBounds height) / 2.0 + aContainerBounds top - aBounds top)