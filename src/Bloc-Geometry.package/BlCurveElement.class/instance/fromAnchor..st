anchor - accessing
fromAnchor: aBlGeometryAnchor

	fromAnchor := aBlGeometryAnchor.
	fromAnchor
		addEventHandlerOn: BlAttachAnchorMoved
		do: [ :anEvent | self onAnchorMoved ].
	self onAnchorMoved