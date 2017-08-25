examples
exampleSimple2x2Grid
	<gtExample>
	| e1 e2 e3 e4 el |
	
	e1 := BlElement new
		size: 150 asPoint;
		background: Color pink.
	
	e2 := BlElement new
		size: 150 asPoint;
		background: Color green.
	
	e3 := BlElement new
		size: 150 asPoint;
		background: Color red.
	
	e4 := BlElement new
		size: 150 asPoint;
		background: Color yellow.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 400@400;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 };
		yourself.
	^ el 