examples
exampleHorizontalListFixedWidthRTL
	<example>
	| e1 e2 e3 el space |
	e1 := BlElement new
		width: 80;
		border: (BlBorder paint: Color darkGray width: 4);
		constraintsDo: [ :c | c vertical matchParent ];
		background: Color red.
		
	e2 := BlElement new
		width: 80;
		border: (BlBorder paint: Color black width: 4);
		constraintsDo: [ :c | c vertical matchParent ];
		background: Color green.
		
	e3 := BlElement new
		width: 80;
		border: (BlBorder paint: Color lightGray width: 4);
		constraintsDo: [ :c | c vertical matchParent ];
		background: Color yellow.
		
	el := BlElement new
		layout: (BlLinearLayout horizontal rightToLeft);
		extent: 450 @ 150;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
		
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space show