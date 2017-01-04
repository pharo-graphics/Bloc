examples
exampleHorizontalSpacing2x1Grid
	<example>
	| e1 e2 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color yellow.

	el := BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 20);
		size: 400@200;
		position: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	
	el forceLayout.
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show
	