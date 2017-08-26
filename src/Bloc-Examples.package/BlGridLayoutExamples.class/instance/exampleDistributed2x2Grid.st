examples
exampleDistributed2x2Grid
	<gtExample>
	| e1 e2 e3 e4 el |
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color pink.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	
	e4 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color yellow.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 300@300;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 };
		yourself.
	^ el