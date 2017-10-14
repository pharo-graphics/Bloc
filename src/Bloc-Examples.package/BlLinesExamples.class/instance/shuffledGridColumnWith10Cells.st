example - grid
shuffledGridColumnWith10Cells
	<gtExample>
	| aGridElement |

	aGridElement := self gridColumnWith10Cells.
	aGridElement children shuffle.
	
	^ aGridElement