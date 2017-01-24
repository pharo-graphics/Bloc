shape examples
exampleGeometry
	| space |
	space := BlSpace new
		extent: 800 @ 650;
		title: 'Shape example'.

	space root
		"addChild: (BlBenchmarkConsole on:space);"
		addChild: (self newPolygon position: 220 @ 0);
		addChild: (self newRoundedRectangle position: 430 @ 50);
		addChild: (self newCircle position: 250 @ 200);
		addChild: (self newSquare position: 400 @ 200);
		addChild: (self newSvg position: 500 @ 200; size: 100@100);
		addChild: (self newLine);
		addChild: (self newRectangle position: 10 @ 150).
	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
				
	space show.
	
	