layout
layoutChunk
	<return: #BlInfiniteLinearLayoutChunkResult>
	| aResult anElement anElementBounds anInfiniteConstraints |
	
	aResult := BlInfiniteLinearLayoutChunkResult new.

	(layoutState hasMoreItems: self state)
		ifFalse: [ ^ aResult finished: true ].

	anElement := self layoutChunkAdd.
	anElementBounds := self layoutChunkMeasure: anElement result: aResult.
	"We calculate everything with Element's bounding box (which includes decor and margins)
	To calculate correct layout position, we subtract margins."
	self layoutDecoratedWithMargins: anElement in: anElementBounds.
	
	anInfiniteConstraints := anElement constraints infinite.
	"Consume the available space if the element is not removed OR changed"
	(anInfiniteConstraints isItemRemoved or: [ anInfiniteConstraints isItemChanged ])
		ifTrue: [ aResult ignoreConsumed: true ].

	aResult focusable: anElement isFocusable.
	^ aResult