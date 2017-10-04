examples
exampleSpacing9x9Grid
	<example>
	| children el space dim |
	
	dim := 9.
	
	children := (1 to: (dim raisedTo: 2)) collect: [ :i |
		BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c grid ];
			background: Color random muchLighter;
			yourself ].

	el := BlElement new
		layout: (BlGridLayout new columnCount: dim; rowCount: dim; yourself);
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ];
		relocate: 0 @ 0;
		background: Color blue;
		addChildren: children;
		yourself.

	el forceLayout.
	
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space	show