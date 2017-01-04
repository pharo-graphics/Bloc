examples
exampleVerticalLeftCenterRightRTL
	<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c vertical exact: 100.
			c linear horizontal alignLeft ];
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 100.
			c linear horizontal alignCenter ];
		background: Color green.
	
	e3 := BlElement new
		size: 50@50;
		constraintsDo: [ :c |
			c linear horizontal alignRight ];
		background: Color yellow.

	el := BlElement new
		layout: BlLinearLayout vertical rightToLeft;
		size: 200@300;
		position: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 }.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	