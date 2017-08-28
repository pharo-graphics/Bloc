anchor - accessing
toAnchor: aBlGeometryAnchor

	toAnchor := aBlGeometryAnchor.
	toAnchor
		addEventHandlerOn: BlAttachAnchorMoved
		do: [ :anEvent | self onToAnchorMoved ].
	self onToAnchorMoved