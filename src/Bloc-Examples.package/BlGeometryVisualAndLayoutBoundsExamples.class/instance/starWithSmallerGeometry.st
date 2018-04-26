star
starWithSmallerGeometry
	<gtExample>
	<label: 'Star element in debug mode, displaying bounds'>
	| aStarElement |
	aStarElement := BlElement new.
	aStarElement geometry: self starPolygon.
	aStarElement size: 200 @ 200.
	aStarElement background: (Color gray alpha: 0.2).
	aStarElement
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 10).
	aStarElement debug: true.
	^ aStarElement