examples
text
	"Does not work"
	| space list container |
	space := BlSpace new
		extent: 550 @ 750;
		title: 'Infinite list example'.

	container := BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.	
	
	list := BlInfiniteExampleTextListElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.

	container addChildren: { list }.
	space root addChild: container.
	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space root
		addChild: (BlBenchmarkConsole on:space).
	space show