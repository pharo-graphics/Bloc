example - grid
shuffledGridColumnWith6Cells
	<gtExample>
	| aGridElement |

	aGridElement := self gridColumnWith6Cells.
	aGridElement children shuffle.
	
	^ aGridElement