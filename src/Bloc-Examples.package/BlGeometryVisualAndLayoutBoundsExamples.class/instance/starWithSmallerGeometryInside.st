star
starWithSmallerGeometryInside
	<gtExample>
	<label: 'Star element with inside stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts inside.
	
	^ aStarElement