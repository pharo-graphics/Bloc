accessing
position: aPosition extent: anExtent
	"I do a hard work of changing element's position and extent.
	This action must be very optimized in the sense of invalidation.
	For example if element becomes smaller in both axis (horizontal and vertical)
	it is enough to invalidate damaged area only once within old bounds,
	the same applies to homogeneous growing: we invalidate once after applying changes.
	Note, I do not request layout update and do not send invalidate to myself if only
	position changes, instead I send invalidate with my effect bounds in parent coordinates
	to my parent. It allows developers to implement drawing cache"
	| isPositionChanged isExtentChanged aPreviousExtent isGrowing isShrinking aPreviousPosition | 
	
	self
		assert: [ aPosition x isInfinite not and: [ aPosition y isInfinite not ] ]
		description: [ 'Position can not be infinite' ].
	
	self
		assert: [ anExtent x isInfinite not and: [ anExtent y isInfinite not ] ]
		description: [ 'Extent can not be infinite' ].
	
	isPositionChanged := (self position closeTo: aPosition) not.
	isExtentChanged := (self extent closeTo: anExtent) not.

	"nothing changed, return"
	(isPositionChanged or: [ isExtentChanged ])
		ifFalse: [ ^ self ].

	aPreviousPosition := self position.
	aPreviousExtent := self extent.

	"If we are growing, there is no need to invalidate before extent change"
	isGrowing := aPreviousExtent <= anExtent.
	"if we are shrinking, there is no need to invalidate after extent change"
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
		self bounds position: aPosition.
		self changes positionChange: aPreviousPosition to: aPosition.

		"position changed without extent => invalidate cached space bounds.
		Note, that if extent changes we invalidate bounds cache anyway"
		isExtentChanged ifFalse: [ boundsCache invalidateBoundsInSpace ] ].

	isExtentChanged ifTrue: [ 
		"change my extent"
		self bounds extent: anExtent.
		self changes extentChange: aPreviousExtent to: anExtent.
		boundsCache invalidateBoundsInLocal ]