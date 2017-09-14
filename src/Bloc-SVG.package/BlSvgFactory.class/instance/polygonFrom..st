polyline & polygon
polygonFrom: node
	|polygon|
	polygon := (BlPolygon vertices: (self pointsFrom: node)) asElement.
	
	self allPropertiesFrom: node attributes on: polygon.
	
	^polygon