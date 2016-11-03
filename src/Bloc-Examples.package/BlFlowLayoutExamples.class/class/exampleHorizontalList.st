as yet unclassified
exampleHorizontalList
<example>
	| e1 e2 e3 e4 el space|
	
	e1 := BlElement new
		extent: 50 asPoint;
		background: (BlBackground fill: Color red).
	
	e2 := BlElement new
		extent: 50 asPoint;
		background: (BlBackground fill: Color green).
	
	e3 := BlElement new
		extent: 50 asPoint;
		background: (BlBackground fill: Color red).
		
	e4 := BlElement new
		extent: 50 asPoint;
		background: (BlBackground fill: Color brown).
	
	el := BlElement new
		layout: BlFlowLayout new;
		extent: 150@100;
		position: 200 @ 100;
		background: (BlBackground fill: Color blue);
		addChildren: {e1. e2. e3. e4}.

	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show.
	el inspect.
	