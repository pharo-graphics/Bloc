star
starWithSmallerGeometryCentered
	<gtExample>
	<label: 'Star element with centered stroke'>
	| aStarElement |
	
	aStarElement := self starWithSmallerGeometry.
	aStarElement outskirts: BlOutskirts centered.
	
	^ aStarElement