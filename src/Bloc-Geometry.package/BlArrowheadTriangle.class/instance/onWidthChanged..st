changes
onWidthChanged: aNumber

	self size: aNumber asPoint * 2.
	self border: (self border copyWithWidth: aNumber / 4.0).
	self geometry: (BlPolygon vertices: {
		0@0.
		(aNumber * 2) @aNumber.
		0@(aNumber * 2)
	})