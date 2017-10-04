examples
exampleVerticalSpacing1x2Grid
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
		layout: (BlGridLayout vertical cellSpacing: 20);
		size: 200@400;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	
	el forceLayout.
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show
	