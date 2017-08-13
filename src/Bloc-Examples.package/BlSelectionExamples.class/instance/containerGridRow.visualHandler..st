examples
containerGridRow: aContainerElement visualHandler: aSelectionHandler
	<gtExample>
	<dependsOn: #container:gridRow:>
	<dependsOn: #visualHandler>
	
	^ aContainerElement addEventHandler: aSelectionHandler