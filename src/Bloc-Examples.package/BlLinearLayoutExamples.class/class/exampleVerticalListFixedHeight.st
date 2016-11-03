examples
exampleVerticalListFixedHeight
	<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		border: (BlBorder color: Color darkGray width: 4);
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		border: (BlBorder color: Color black width: 4);
		background: Color yellow.
	
	e3 := BlElement new
		constraintsDo: [ :c | c horizontal matchParent ];
		border: (BlBorder color: Color lightGray width: 4);
		background: Color green.
	
	el := BlElement new
		layout: BlLinearLayout vertical;
		extent: 80@300;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	