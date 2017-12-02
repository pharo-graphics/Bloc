example - grid
gridWith12Cells
	<gtExample>
	| cells |

	cells := (1 to: 12) collect: [ :i | self gridCell ].

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BrRopedText string: anIndex asString) ].
	
	^ self grid
		layoutDo: [ :aGridLayout | aGridLayout rowCount: 4 ];
		addChildren: cells;
		yourself