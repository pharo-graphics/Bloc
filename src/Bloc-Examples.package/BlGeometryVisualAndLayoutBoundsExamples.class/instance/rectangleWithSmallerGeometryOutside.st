rectangle
rectangleWithSmallerGeometryOutside
	<gtExample>
	<label: 'Rectangle element with outside stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts outside.
	
	^ aRectangleElement