as yet unclassified
exampleHorizontalList
<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c | c vhMatchParent ];
		background: (BlBackground fill: Color red).
	
	e2 := BlElement new
		constraintsDo: [ :c | c vhMatchParent ];
		background: (BlBackground fill: Color green).
	
	e3 := BlElement new
		constraintsDo: [ :c | c vhMatchParent ];
		background: (BlBackground fill: Color red).
	
	el := BlElement new
		layout: BlLinearLayout horizontal;
		extent: 300@80;
		position: 200 @ 100;
		background: (BlBackground fill: Color blue);
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	