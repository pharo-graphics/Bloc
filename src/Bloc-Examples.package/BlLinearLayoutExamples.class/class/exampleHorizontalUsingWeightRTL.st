examples
exampleHorizontalUsingWeightRTL
<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ];
		background: Color red.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 2 ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 3 ];
		background: Color yellow.
	
	el := BlElement new
		layout: BlLinearLayout horizontal rightToLeft;
		size: 300@80;
		position: 200 @ 100;
		background: (BlBackground paint: Color blue);
		addChildren: {e1. e2. e3}.

	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	