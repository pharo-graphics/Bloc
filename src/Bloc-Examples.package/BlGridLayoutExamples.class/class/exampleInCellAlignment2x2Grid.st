examples
exampleInCellAlignment2x2Grid
	<example>
	| e1 e2 e3 el space|

	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 100.
			c vertical matchParent.
			c grid vertical span: 2 ];
		background: Color yellow.

	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 100.
			c vertical exact: 50.
			c grid horizontal alignCenter ];
		background: Color green.

	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 100.
			c grid vertical alignBottom.
			c grid horizontal weight: 2 ];
		background: Color red.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 300@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 };
		yourself.
	
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show
	