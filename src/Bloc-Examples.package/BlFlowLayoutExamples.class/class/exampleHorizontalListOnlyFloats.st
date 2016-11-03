examples
exampleHorizontalListOnlyFloats
	<example>
	| floats parent space random |
	random := Random new.
	floats := (1 to: 10) collect: [:i | 
		BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 100.
				c vertical exact: (random nextInt: 50) + 25.
				c margin: (BlInsets top: 3 right: 0 bottom: 0 left: 3) ];
			background: Color veryVeryLightGray;
			yourself ].
		
	parent := BlElement new
		layout: BlFlowLayout new horizontal;
		extent: 560@400;
		position: 100 @ 50;
		background: Color white;
		addChildren: floats;
		yourself.
	
	parent forceLayout.
	space := BlSpace new.
	space root addChild: parent.
	BlElementSelection on: parent.
	space show