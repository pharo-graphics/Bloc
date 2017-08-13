examples
container: aContainerElement grid: aGrid_1 grid: aGrid_2 grid: aGrid_3
	<gtExample>
	<dependsOn: #container>
	<dependsOn: #grid:with:with:with:with:with:with:with:with:with:with:with:>
	<dependsOn: #grid:with:with:with:with:with:with:with:with:with:with:with:>
	<dependsOn: #grid:with:with:with:with:with:with:with:with:with:with:with:>
	
	^ aContainerElement
		layout: BlGridLayout horizontal;
		layoutDo: [ :l | l cellSpacing: 10 ];
		addChildren: { aGrid_1 . aGrid_2 . aGrid_3 }