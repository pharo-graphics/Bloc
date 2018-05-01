geometry bounds
geometryBounds: aBounds
	^ (aBounds rectangle: (self controlPoints
			ifEmpty: [ 0@0 extent: 0@0 ]
			ifNotEmpty: [ :theControlPoints | Rectangle encompassing: theControlPoints ]))