examples
container: aContainerElement gridRow: aGridRowElement
	<gtExample>
	<dependsOn: #container>
	<dependsOn: #container:grid:grid:grid:>
	
	^ aContainerElement
		addChild: aGridRowElement