anchors
registerAnchor: aGeometryAnchor
	"Register a given geometry anchor as one of my anchors"

	aGeometryAnchor
		addEventHandlerOn: BlGeometryAnchorMoved
		do: [ :anEvent | self onAnchorMoved ].
	self onAnchorMoved