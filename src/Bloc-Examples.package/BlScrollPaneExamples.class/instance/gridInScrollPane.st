examples - grid
gridInScrollPane
	<gtExample>
	| aGridElement aScrollPane |
	
	aGridElement := BlElement new.
	aGridElement layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	aGridElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	aGridElement addChildren: (50 timesCollect: [ :anIndex |
		BlTextElement new
			text: (anIndex asString asRopedText foreground: Color gray);
			size: 120@120;
			background: (Color gray alpha: (20 to: 50) atRandom / 100.0)]).

	aScrollPane := BlScrollableElement new.
	aScrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aScrollPane addChild: aGridElement.

	^ aScrollPane.