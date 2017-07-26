example - grid
gridColumn: aGridElement with: aCell1 with: aCell2 with: aCell3 with: aCell4 with: aCell5 with: aCell6
	<gtExample>
	<dependsOn: #grid>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	| cells |

	cells := { 
		aCell1 . aCell2 . aCell3 . aCell4 . aCell5 . aCell6
 	}.

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BrRopedText string: anIndex asString) ].
	
	^ aGridElement
		layoutDo: [ :aGridLayout | aGridLayout columnCount: 1 ];
		addChildren: cells;
		yourself