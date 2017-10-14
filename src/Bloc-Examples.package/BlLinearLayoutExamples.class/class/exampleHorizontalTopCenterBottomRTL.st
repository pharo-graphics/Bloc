examples
exampleHorizontalTopCenterBottomRTL
<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignTop ];
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignCenter ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignBottom ];
		background: Color yellow.
	
	el := BlElement new
		layout: BlLinearLayout horizontal rightToLeft;
		size: 300@80;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	