examples
exampleHorizontalList
	<example>
	| e1 e2 e3 e4 el space e5 |

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
	
	e5 := BlElement new
		size: 50 asPoint;
		geometry: BlEllipse new;
		background: Color orange.

	el := BlElement new
		layout: BlFlowLayout new horizontal;
		size: 166@300;
		relocate: 200 @ 100;
		background: Color veryLightGray;
		border: (BlBorder paint: Color lightGray width: 8);
		padding: (BlInsets all: 8);
		addChildren: { e1. e2. e3. e4 . e5 }.

	space := BlSpace new.
	space root addChild:el.
	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show