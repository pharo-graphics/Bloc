bounds
debuggingMode
	<gtExample>
	<label: 'Triangle polygon with visual and geometry bounds'>
	| aContainer aTriangleElement |
	aContainer := self fullyVisibleTriangle.
	aTriangleElement := aContainer children first.
	aTriangleElement debug: true.
	^ aContainer