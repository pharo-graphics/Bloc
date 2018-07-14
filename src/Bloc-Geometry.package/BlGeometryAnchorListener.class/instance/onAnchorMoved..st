anchors
onAnchorMoved: aBlGeometryAnchor
	| aPosition |
	
	aPosition := (aBlGeometryAnchor computePositionWithin: self geometryElement).
	(aPosition = aBlGeometryAnchor computedPosition)
		ifTrue: [ ^ self ]
		ifFalse: [ aBlGeometryAnchor computedPosition: aPosition ].

	self onAnchorMoved