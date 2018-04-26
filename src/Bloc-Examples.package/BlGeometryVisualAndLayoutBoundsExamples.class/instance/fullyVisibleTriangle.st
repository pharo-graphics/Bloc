bounds
fullyVisibleTriangle
	<gtExample>
	<label: 'Fully visible triangle polygon that exceeds layout bounds'>
	| aContainer |
	aContainer := self clippedTriangle.
	aContainer clipChildren: false.
	aContainer relocate: 30@30.
	^ aContainer