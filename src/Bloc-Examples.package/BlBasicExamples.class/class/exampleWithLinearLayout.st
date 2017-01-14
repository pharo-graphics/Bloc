element examples
exampleWithLinearLayout
	|c1 c2 c3 sp p |
	
	c1 := BlElement new
		constraintsDo: [ :c | c linear vertical alignBottom ];
		background: Color red.

	c2 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		background: Color green.
	
	c3 := BlElement new
		constraintsDo: [ :c| c linear vertical alignBottom ];
		background: Color yellow.
	
	p := BlElement new
		layout: BlLinearLayout horizontal;
		size: 200 @ 300;
		position: 200@100;
		background: (BlBackground fill: Color blue);
		padding: (BlInsets all:10);
		addChildren: {c1.c2.c3}.
	
		
	sp := BlSpace new.
	sp root addChild: p.
	sp root addChild: (BlBenchmarkConsole on:sp).
	sp root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	sp show.
	