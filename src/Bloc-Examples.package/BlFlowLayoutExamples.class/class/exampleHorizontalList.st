examples
exampleHorizontalList
	<example>
	| e1 e2 e3 e4 el space|

	e1 := BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 50.
			c vertical exact: 150 ];
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 100.
			c vertical exact: 50 ];
		background: Color green.
	
	e3 := BlElement new
		size: 50 asPoint;
		background: Color yellow.

	e4 := BlElement new
		size: 50 asPoint;
		background: Color magenta.

	el := BlElement new
		layout: BlFlowLayout new horizontal;
		size: 150@200;
		position: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 }.

	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show