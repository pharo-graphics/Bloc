scrolling
updateCubic: aDeltaTime
	| aTime aSquaredTime aSign |
	
	aTime := aDeltaTime / duration.
	aSquaredTime := aTime * aTime.
	aSign := startVelocity sign.
	
	self currentVelocity: aSign * 6.0 * (aSquaredTime - aTime).
	
	^ aSign * overshotDistance * ((3.0 * aSquaredTime) - (2 * aTime * aSquaredTime))