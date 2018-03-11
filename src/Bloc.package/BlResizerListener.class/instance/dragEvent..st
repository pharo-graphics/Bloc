dnd handlers
dragEvent: anEvent
	| dragPosition dragDelta theBounds |
	anEvent consumed: true.

	dragPosition := anEvent position.
	dragDelta := dragPosition - dragStartPosition.

	theBounds := BlBounds origin: originalPosition extent: originalExtent.
	self
		resizeBounds: theBounds
		by: dragDelta.
	
	self resizeTarget globalBoundsToLocal: theBounds.
	self resizeTarget localBoundsToParent: theBounds.

	self resizeTarget
		relocate: theBounds position;
		size: theBounds extent