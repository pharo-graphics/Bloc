changes
onWidthChanged: aNumber

	self size: aNumber asPoint * 2.
	self border: (self border copyWithWidth: aNumber).
	self geometry: (BlPolygon vertices: {
		0@0.
		aNumber@aNumber.
		0@(aNumber * 2)
	}).