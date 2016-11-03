as yet unclassified
exampleSimple2x2Grid
<example>
	| e1 e2 e3 e4 el space|
	
	e1 := BlElement new
		extent: 150 asPoint;
		border: (BlBorder color: Color darkGray width: 4);
		background: (BlBackground fill: Color pink).
	
	e2 := BlElement new
		extent: 150 asPoint;
		border: (BlBorder color: Color black width: 4);
		background: (BlBackground fill: Color green).
	
	e3 := BlElement new
		extent: 150 asPoint;
		border: (BlBorder color: Color lightGray width: 4);
		background: (BlBackground fill: Color red).
	
	e4 := BlElement new
		extent: 150 asPoint;
		border: (BlBorder color: Color brown width: 4);
		background: (BlBackground fill: Color yellow).
	
	el := BlElement new
		layout: (BlGridLayout new columnCount:3;cellSpacing:4);
		extent: 300@300;
		position: 200 @ 100;
		background: (BlBackground fill: Color blue);
		addChildren: {e1. e2. e3. e4}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space	show
	