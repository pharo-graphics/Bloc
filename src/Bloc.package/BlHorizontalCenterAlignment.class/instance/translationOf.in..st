translation
translationOf: aBounds in: aContainerBounds
	<return: #Point>
	
	^ ((aContainerBounds width - aBounds width) / 2.0 + aContainerBounds left - aBounds left) @ 0