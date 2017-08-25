examples
exampleVerticalSpacing1x2Grid
	<gtExample>
	| e1 e2 el |
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color yellow.
	el := BlElement new
		layout: (BlGridLayout vertical cellSpacing: 20);
		size: 200@400;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	^ el 