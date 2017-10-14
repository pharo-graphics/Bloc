examples
exampleVerticalList
<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color darkGray width: 4);
		background: Color red.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color black width: 4);
		background: Color yellow.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color lightGray width: 4);
		background: Color green.
	
	el := BlElement new
		layout: BlLinearLayout vertical;
		size: 80@300;
		relocate: 200 @ 100;
		padding: (BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	