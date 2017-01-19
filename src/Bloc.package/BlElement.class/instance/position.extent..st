accessing
position: aPosition extent: anExtent
	"I do hard work of changing element's position and extent.
	This action must be very optimized in the sense of invalidation.
	For example if element becomes smaller in both axis (horizontal and vertical)
	it is enough to invalidate damaged area only once within old bounds,
	the same applies to homogeneous growing: we invalidate once after applying changes.
	Note, I do not request layout update and do not send invalidate to myself if only
	position changes, instead I send invalidate with my effect bounds in parent coordinates
	to my parent. It allows developers to implement drawing cache"
	| isPositionChanged isExtentChanged aPreviousExtent isGrowing isShrinking | 
		
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
		ifTrue: [ 
			isExtentChanged
				"If extent changes we have to invalidate my own damaged area"
				ifTrue: [ self invalidate ]
				"Otherwise invalidate in my parent"
				ifFalse: [ self invalidateInParent ] ].

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
		ifTrue: [
			isExtentChanged
				"If extent changes we have to invalidate my own damaged area"
				ifTrue: [ self invalidate ]
				"Otherwise invalidate in my parent"
				ifFalse: [ self invalidateInParent ] ]