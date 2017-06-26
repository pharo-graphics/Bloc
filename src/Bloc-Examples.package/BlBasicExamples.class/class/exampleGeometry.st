shape examples
exampleGeometry
	| space |
	space := BlSpace new
		extent: 600 @ 450;
		title: 'Shape example'.

	space root
		"addChild: (BlBenchmarkConsole on:space);"
		addChild: (self newPolygon position: 220 @ 0);
		addChild: (self newRoundedRectangle position: 430 @ 50);
		addChild: (self newCircle position: 250 @ 200);
		addChild: (self newSquare position: 400 @ 200);
		addChild: (self newSvg position: 500 @ 200);
		"addChild: (self newLine);"
		addChild: (self newRectangle position: 10 @ 150);
		yourself.

	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	
	space show