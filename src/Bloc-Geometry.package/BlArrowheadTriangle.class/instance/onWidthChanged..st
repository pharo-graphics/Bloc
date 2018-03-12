changes
onWidthChanged: aNumber
	| aScaledWidth |
	
	aScaledWidth := self scale * aNumber.

	self size: aScaledWidth asPoint * 2.
	self border: (self border copyWithWidth: aNumber / 4.0).
	self geometry: (BlPolygon vertices: {
		0@0.
		(aScaledWidth * 2) @aScaledWidth.
		0@(aScaledWidth * 2)
	})