shape examples
exampleShapes
	| space |
	space := BlSpace new
		extent: 600 @ 350;
		title: 'Shapes'.

	space root
		addChild: (self new shapes);
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show