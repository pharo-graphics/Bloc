examples
exampleVertical1x2Grid
	<example>
	| e1 e2 el space|
	
	e1 := BlElement new
		size: 150 asPoint;
		background: Color red.
	
	e2 := BlElement new
		size: 150 asPoint;
		background: Color yellow.

	el := BlElement new
		layout: BlGridLayout vertical;
		size: 400@400;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	
	el forceLayout.
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show
	