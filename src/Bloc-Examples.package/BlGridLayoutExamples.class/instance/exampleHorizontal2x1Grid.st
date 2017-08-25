examples
exampleHorizontal2x1Grid
	<gtExample>
	| e1 e2 el|
	
	e1 := BlElement new
		size: 150 asPoint;
		background: Color red.
	
	e2 := BlElement new
		size: 150 asPoint;
		background: Color yellow.

	el := BlElement new
		layout: BlGridLayout horizontal;
		size: 400@400;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	^ el