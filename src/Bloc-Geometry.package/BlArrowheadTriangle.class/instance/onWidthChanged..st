changes
onWidthChanged: aNumber

	self size: aNumber asPoint * 2.
	self geometry: (BlPolygon vertices: {
		0@0.
		(aNumber * 2) @aNumber.
		0@(aNumber * 2)
	})