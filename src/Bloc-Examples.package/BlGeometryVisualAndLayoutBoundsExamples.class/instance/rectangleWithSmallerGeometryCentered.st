rectangle
rectangleWithSmallerGeometryCentered
	<gtExample>
	<label: 'Rectangle element with centered stroke'>
	| aRectangleElement |
	
	aRectangleElement := self rectangleWithSmallerGeometry.
	aRectangleElement outskirts: BlOutskirts centered.
	
	^ aRectangleElement