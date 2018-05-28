dnd handlers
dragEvent: anEvent
	<event: #BlResizerResizedEvent>
	| dragPosition dragDelta theBounds theOriginalBounds widthChanged heightChanged |
	anEvent consumed: true.

	dragPosition := anEvent position.
	dragDelta := dragPosition - dragStartPosition.

	theBounds := BlBounds origin: originalPosition extent: originalExtent.
	theOriginalBounds := theBounds copy.

	self
		resizeBounds: theBounds
		by: dragDelta.
	
	widthChanged := theBounds width ~= theOriginalBounds width.
	heightChanged := theBounds height ~= theOriginalBounds height.
	
	self resizeTarget globalBoundsToLocal: theBounds.
	self resizeTarget localBoundsToParent: theBounds.

	self resizeTarget relocate: theBounds position.
	
	(widthChanged or: [ heightChanged ])
		ifFalse: [ ^ self ].

	widthChanged
		ifTrue: [ self resizeTarget width: theBounds width ].

	heightChanged
		ifTrue: [ self resizeTarget height: theBounds height ].
	
	anEvent currentTarget dispatchEvent: BlResizerResizedEvent new