examples
exampleSimple2x2Grid
	<example>
	| e1 e2 e3 e4 el space|
	
	e1 := BlElement new
		extent: 150 asPoint;
		background: Color pink.
	
	e2 := BlElement new
		extent: 150 asPoint;
		background: Color green.
	
	e3 := BlElement new
		extent: 150 asPoint;
		background: Color red.
	
	e4 := BlElement new
		extent: 150 asPoint;
		background: Color yellow.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		extent: 400@400;
		position: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 };
		yourself.
	
	el forceLayout.
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show
	