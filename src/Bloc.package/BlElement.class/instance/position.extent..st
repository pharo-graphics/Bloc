accessing
position: aPosition extent: anExtent
	| isPositionChanged isExtentChanged aPreviousExtent isGrowing isShrinking | 
	"Note, I do not request layout update"
		
	isPositionChanged := self position ~= aPosition.
	isExtentChanged := self extent ~= anExtent.

	"nothing changed, return"
	(isPositionChanged or: [ isExtentChanged ])
		ifFalse: [ ^ self ].
	
	aPreviousExtent := self extent.

	"If we are growing there is no need to invalidate before extent change"
	isGrowing := aPreviousExtent <= anExtent.
	"if we are shrinking there is no need to invalidate after extent change"
	isShrinking := aPreviousExtent >= anExtent.

	"damage area according to my previous space bounds"
	(isPositionChanged or: [ isShrinking or: [ isGrowing not ] ])
		ifTrue: [ self invalidate ].
	
	isPositionChanged ifTrue: [
		"change my position"
		self positionProperty value: aPosition.
		self notifyPositionChanged.
		"position changed without extent => invalidate cached space bounds.
		Note, that if extent changes we invalidate bounds cache anyway"
		isExtentChanged ifFalse: [ boundsCache invalidateBoundsInSpace ] ].

	isExtentChanged ifTrue: [ 
		"change my extent"
		self extentProperty value: anExtent.
		self notifyExtentChanged.

		"extent changed => invalidate cached local bounds"
		boundsCache invalidateBoundsInLocal.
		"extent changed => path also"
		self updatePath.
		pathCache releaseCache ].

	"damage area after position change"
	(isPositionChanged or: [ isGrowing or: [ isShrinking not ] ])
		ifTrue: [ self invalidate ]