layout
layoutChunkMeasure: anElement result: aResult
	<return: #Rectangle>

	self measureChildWithMargins: anElement widthUsed: 0 heightUsed: 0.
	aResult consumedSpace: (self orientation decoratedMeasurement: anElement).
	
	^ self orientation isVertical
		ifTrue: [ self layoutChunkMeasureVertical: anElement result: aResult ]
		ifFalse: [ self layoutChunkMeasureHorizontal: anElement result: aResult ]