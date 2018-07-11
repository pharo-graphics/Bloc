anchors
onAnchorMoved: aBlGeometryAnchor
	| aPosition |
	
	aPosition := (aBlGeometryAnchor positionWithin: self geometryElement).
	(aPosition = aBlGeometryAnchor previousPosition)
		ifTrue: [ ^ self ]
		ifFalse: [ aBlGeometryAnchor previousPosition: aPosition ].

	self onAnchorMoved