anchor - accessing
fromAnchor: aBlGeometryAnchor

	fromAnchor := aBlGeometryAnchor.
	fromAnchor
		addEventHandlerOn: BlGeometryAnchorMoved
		do: [ :anEvent | self onFromAnchorMoved ].
	self onFromAnchorMoved