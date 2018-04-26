rectangle
rectangleWithSmallerGeometry
	<gtExample>
	<label: 'Rectangle element in debug mode, displaying bounds'>
	| aRectangleElement |
	
	aRectangleElement := BlElement new.
	aRectangleElement geometry: self rectanglePolygon.
	aRectangleElement size: 200@150.
	aRectangleElement background: (Color gray alpha: 0.2).
	aRectangleElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	aRectangleElement debug: true.
	
	^ aRectangleElement