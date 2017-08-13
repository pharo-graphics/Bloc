examples
grid: aGridElement with: aCell_1  with: aCell_2  with: aCell_3  with: aCell_4  with: aCell_5  with: aCell_6  with: aCell_7  with: aCell_8  with: aCell_9 with: aCell_10 with: aCell_11
	<gtExample>
	<dependsOn: #grid>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	<dependsOn: #cell>
	
	aGridElement
		addChildren: {
			aCell_1 . aCell_2 . aCell_3 . aCell_4 . aCell_5.
			aCell_6 . aCell_7 . aCell_8 . aCell_9 . aCell_10.
			aCell_11 }.
			
	^ aGridElement