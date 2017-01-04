examples
exampleHorizontalListFloat
	<example>
	| before floatA middle floatB after parent space |

	before := (1 to: 2) collect: [:i | 
		BlElement new
			constraintsDo: [ :c | 
				c horizontal exact: 50.
				c vertical exact: 25.
				c margin: (BlInsets top: 3 right: 0 bottom: 0 left: 3) ];
			background: Color veryVeryLightGray;
			yourself ].

	floatA := BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 103.
			c vertical exact: 165.
			c margin: (BlInsets top: 3 right: 0 bottom: 0 left: 3) ];
		background: Color magenta.
		
	middle := (1 to: 30) collect: [:i | 
		BlElement new
			constraintsDo: [ :c | 
				c horizontal exact: 50.
				c vertical exact: 25.
				c margin: (BlInsets top: 3 right: 0 bottom: 0 left: 3) ];
			background: Color veryVeryLightGray darker;
			yourself ].
		
	floatB := BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 50.
			c vertical exact: 109.
			c margin: (BlInsets top: 3 right: 0 bottom: 0 left: 3) ];
		background: Color blue.
	
	after := (1 to: 4) collect: [:i | 
		BlElement new
			constraintsDo: [ :c | 
				c horizontal exact: 50.
				c vertical exact: 25.
				c margin: (BlInsets top: 3 right: 0 bottom: 0 left: 3) ];
			background: Color veryVeryLightGray darker darker;
			yourself ].
		
	parent := BlElement new
		layout: BlFlowLayout new horizontal;
		size: 560@400;
		position: 100 @ 50;
		background: Color white;
		addChildren: before;
		addChild: floatA;
		addChildren: middle;
		addChild: floatB;
		addChildren: after;
		yourself.
	
	space := BlSpace new.
	space root addChild: parent.
	BlElementSelection on: parent.
	space show