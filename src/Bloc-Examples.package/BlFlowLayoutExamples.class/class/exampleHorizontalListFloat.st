examples
exampleHorizontalListFloat
	<example>
	| before floatA middle floatB after parent space |

	before := (1 to: 2) collect: [:i | 
		BlElement new
			constraintsDo: [ :c | 
				c horizontal exact: 50.
				c vertical exact: 25.
				c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
			background: Color veryLightGray;
			yourself ].

	floatA := BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 103.
			c vertical exact: 165.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
		background: (Color red).
		
	middle := (1 to: 30) collect: [:i | 
		BlElement new
			constraintsDo: [ :c | 
				c horizontal exact: 50.
				c vertical exact: 25.
				c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
			background: (Color red alpha: 0.5);
			yourself ].
		
	floatB := BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 50.
			c vertical exact: 109.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
		background: Color blue.
	
	after := (1 to: 4) collect: [:i | 
		BlElement new
			constraintsDo: [ :c | 
				c horizontal exact: 50.
				c vertical exact: 25.
				c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
			background: (Color blue alpha: 0.5);
			yourself ].
		
	parent := BlElement new
		layout: BlFlowLayout new horizontal;
		border: (BlBorder paint: Color lightGray width: 8);
		size: 560@400;
		position: 100 @ 50;
		background: Color white darker;
		addChildren: before;
		addChild: floatA;
		addChildren: middle;
		addChild: floatB;
		addChildren: after;
		yourself.

	space := BlSpace new.
	space root addChild: parent.
	space root addEventHandler:
			(BlEventHandler
				on: BlDblClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show