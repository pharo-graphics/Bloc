changes
onWidthChanged: aNumber
	| aWidth aHeight anOuterWidth anOuterHeight |
	
	aWidth := self computeInnerWidth: aNumber.
	aHeight := self computeInnerHeight: aNumber.

	anOuterWidth := self computeOuterWidth: aNumber.
	anOuterHeight := self computeOuterHeight: aNumber.

	self size: aWidth @ aHeight.
	
	self geometry: (BlPolygon vertices: {
			(aWidth - anOuterWidth) @ ((aHeight - anOuterHeight) / 2.0).
			aWidth @ (aHeight / 2.0).
			(aWidth - anOuterWidth) @ ((aHeight + anOuterHeight) / 2.0).
			0@aHeight.
			0@0.
		})