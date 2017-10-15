matrix - transforming points
transformBounds: aBlBounds
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>

	| quads minX maxX minY maxY|
	
	quads := { 
		self transformPoint: (BlPoint2D x: aBlBounds left y: aBlBounds top).
		self transformPoint: (BlPoint2D x: aBlBounds right y: aBlBounds top).
		self transformPoint: (BlPoint2D x: aBlBounds left y: aBlBounds bottom).
		self transformPoint: (BlPoint2D x: aBlBounds right y: aBlBounds bottom).
	}.
	
	minX := maxX := quads first x.
	minY := maxY := quads first y.
	
	quads do: [ :aQuad |
		minX := minX min: aQuad x.
		minY := minY min: aQuad y.
		maxX := maxX max: aQuad x.
		maxY := maxY max: aQuad y ].

	^ aBlBounds
		left: minX
		top: minY
		right: maxX
		bottom: maxY