examples
example1
<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color darkGray width: 4);
		background: Color yellow.
	
	e2 := BlElement new
		size: 200@200;
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignBottom ];
		border: (BlBorder paint: Color black width: 4);
		background: Color green.
	
	e3 := BlElement new
		size: 100@100;
		constraintsDo: [ :c|
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		border: (BlBorder paint: Color lightGray width: 4);
		background: Color red.
	
	el := BlElement new
		layout: BlFrameLayout new;
		size: 350@350;
		position: 200 @ 100;
		padding: (BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space  show
	