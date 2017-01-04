examples
exampleNautilusGrid
	<example>
	| e1 e2 e3 e4 e5 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.
	
	e4 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.

	e5 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid horizontal span: 4 ];
		background: Color white.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 4; cellSpacing: 10);
		size: 300@300;
		position: 200 @ 100;
		background: Color veryLightGray;
		addChildren: { e1. e2. e3. e4. e5 };
		yourself.
	
	el forceLayout.
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show
	