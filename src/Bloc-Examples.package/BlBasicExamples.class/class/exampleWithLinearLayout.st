element examples
exampleWithLinearLayout
	|c1 c2 c3 sp p |
	
	c1 := BlElement new
		constraintsDo: [:c| c vertical alignBottom];
		background:(BlBackground fill: Color red).
	
	c2 := BlElement new
		constraintsDo: [:c| c horizontal matchParent];
		background:(BlBackground fill: Color green).
	
	c3 := BlElement new
		constraintsDo: [:c| c vertical alignBottom];
		background:(BlBackground fill: Color red).
	
	
	p := BlElement new
		layout: BlLinearLayout horizontal;
		extent: 200 @ 300;
		position: 200@100;
		background:(BlBackground fill: Color blue);
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
	