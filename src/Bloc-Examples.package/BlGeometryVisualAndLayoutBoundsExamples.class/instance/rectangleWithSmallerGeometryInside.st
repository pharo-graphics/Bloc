rectangle
rectangleWithSmallerGeometryInside
	<gtExample>
	<label: 'Rectangle element with inside stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts inside.
	
	^ aRectangleElement