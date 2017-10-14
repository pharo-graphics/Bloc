examples
exampleHorizontalListFixedWidthLTR
	<example>
	| e1 e2 e3 el space |
	e1 := BlElement new
		border: (BlBorder paint: Color darkGray width: 4);
		constraintsDo: [ :c |
			c horizontal exact: 80.
			c vertical matchParent ];
		background: Color red.

	e2 := BlElement new
		border: (BlBorder paint: Color black width: 4);
		constraintsDo: [ :c |
			c horizontal exact: 80.
			c vertical matchParent ];
		background: Color green.
	
	e3 := BlElement new
		border: (BlBorder paint: Color lightGray width: 4);
		constraintsDo: [ :c |
			c horizontal exact: 80.
			c vertical matchParent ];
		background: Color yellow.
		
	el := BlElement new
		layout: BlLinearLayout horizontal;
		size: 450 @ 150;
		relocate: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
		
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space show