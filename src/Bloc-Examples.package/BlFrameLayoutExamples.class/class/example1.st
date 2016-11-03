as yet unclassified
example1
<example>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c | c vhMatchParent ];
		border: (BlBorder color: Color darkGray width: 4);
		background: (BlBackground fill: Color red).
	
	e2 := BlElement new
		extent: 200@200;
		constraintsDo: [ :c | c alignBottomRight ];
		border: (BlBorder color: Color black width: 4);
		background: (BlBackground fill: Color green).
	
	e3 := BlElement new
		extent: 100@100;
		constraintsDo: [ :c| c alignCenter];
		border: (BlBorder color: Color lightGray width: 4);
		background: (BlBackground fill: Color red).
	
	el := BlElement new
		layout: BlFrameLayout new;
		extent: 300@300;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: (BlBackground fill: Color blue);
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space  show
	