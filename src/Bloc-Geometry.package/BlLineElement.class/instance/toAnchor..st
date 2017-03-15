anchor - accessing
toAnchor: aBlGeometryAnchor

	toAnchor := aBlGeometryAnchor.
	toAnchor
		addEventHandlerOn: BlGeometryAnchorMoved
		do: [ :anEvent | self onToAnchorMoved ].
	self onToAnchorMoved