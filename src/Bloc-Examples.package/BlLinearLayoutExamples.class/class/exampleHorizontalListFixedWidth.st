as yet unclassified
exampleHorizontalListFixedWidth
	<example>
	| e1 e2 e3 el space |
	e1 := BlElement new
		width: 80;
		border: (BlBorder color: Color darkGray width: 4);
		constraintsDo: [ :c | c vMatchParent ];
		background: (BlBackground fill: Color red).
		
	e2 := BlElement new
		width: 80;
		border: (BlBorder color: Color black width: 4);
		constraintsDo: [ :c | c vMatchParent ];
		background: (BlBackground fill: Color green).
		
	e3 := BlElement new
		width: 80;
		border: (BlBorder color: Color lightGray width: 4);
		constraintsDo: [ :c | c vMatchParent ];
		background: (BlBackground fill: Color red).
		
	el := BlElement new
		layout: BlLinearLayout horizontal;
		extent: 300 @ 80;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: (BlBackground fill: Color blue);
		addChildren: {e1. e2. e3}.
		
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space show