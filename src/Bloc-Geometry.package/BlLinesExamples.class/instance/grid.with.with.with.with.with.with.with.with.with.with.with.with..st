example - grid
grid: aGridElement with: aCell1 with: aCell2 with: aCell3 with: aCell4 with: aCell5 with: aCell6 with: aCell7 with: aCell8 with: aCell9 with: aCell10 with: aCell11 with: aCell12
	<gtExample>
	<dependsOn: #grid>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	<dependsOn: #gridCell>
	| cells |

	cells := { 
		aCell1 . aCell2 . aCell3 . aCell4 . aCell5.
		aCell6 . aCell7 . aCell8 . aCell9 . aCell10.
		aCell11. aCell12.
 	}.

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BrRopedText string: anIndex asString) ].
	
	^ aGridElement
		layoutDo: [ :aGridLayout | aGridLayout rowCount: 4 ];
		addChildren: cells;
		yourself