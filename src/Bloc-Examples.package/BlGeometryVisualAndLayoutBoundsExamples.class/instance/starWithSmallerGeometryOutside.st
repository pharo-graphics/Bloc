star
starWithSmallerGeometryOutside
	<gtExample>
	<label: 'Star element with outside stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts outside.
	
	^ aStarElement