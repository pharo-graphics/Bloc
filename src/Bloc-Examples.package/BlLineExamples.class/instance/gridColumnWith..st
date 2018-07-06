example - grid
gridColumnWith: aNumberOfCells
	<gtExample>
	| cells |

	cells := (1 to: aNumberOfCells) collect: [ :i | self gridCell ].

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BlRopedText string: anIndex asString) ].
	
	^ self grid
		layoutDo: [ :aGridLayout | aGridLayout columnCount: 1 ];
		addChildren: cells;
		yourself