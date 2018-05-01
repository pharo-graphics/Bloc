example - grid
gridColumnWith: aNumberOfCells
	<gtExample>
	| cells |

	cells := (1 to: aNumberOfCells) collect: [ :i | self gridCell ].

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BrRopedText string: anIndex asString) ].
	
	^ self grid
		layoutDo: [ :aGridLayout | aGridLayout layout columnCount: 1 ];
		addChildren: cells;
		yourself