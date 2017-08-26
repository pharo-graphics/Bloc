examples
exampleVerticalListFixedHeight
	<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		border: (BlBorder paint: Color darkGray width: 4);
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		border: (BlBorder paint: Color gray width: 4);
		background: Color yellow.
	
	e3 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		border: (BlBorder paint: Color lightGray width: 4);
		background: Color green.
	
	el := BlElement new
		layout: BlLinearLayout vertical;
		size: 80@300;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color paleBlue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	