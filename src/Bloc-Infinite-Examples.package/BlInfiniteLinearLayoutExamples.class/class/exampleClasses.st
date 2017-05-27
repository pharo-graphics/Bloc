examples
exampleClasses
	| space list container |
	space := BlSpace new
		extent: 500 @ 650;
		title: 'Smalltalk allClasses'.
		
	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets top: 5) ];
		yourself.	
	
	list := BlInfiniteExampleClassesListElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical matchParent ];
		yourself.
	
	container addChild: list.
	
	space root addChild: container.
	space root addChild: (BlBenchmarkConsole on:space).
	"space root
		addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ])."
	space show