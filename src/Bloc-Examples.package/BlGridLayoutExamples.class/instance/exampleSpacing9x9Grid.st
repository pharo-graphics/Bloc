examples
exampleSpacing9x9Grid
	<gtExample>
	| children element dimension |
	dimension := 9.	
	children := (1 to: (dimension raisedTo: 2)) collect: [ :i |
		BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c grid ];
			background: Color random muchLighter;
			yourself ].
	element := BlElement new
		layout: (BlGridLayout new columnCount: dimension; rowCount: dimension; yourself);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChildren: children;
		yourself.
	^ element