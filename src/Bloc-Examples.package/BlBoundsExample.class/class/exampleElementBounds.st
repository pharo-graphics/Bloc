as yet unclassified
exampleElementBounds
	| el parent |
	el := BlElement new
		extent: 200 @ 200;
		background: Color green;
		padding: (BlInsets all: 30);
		margin: (BlInsets all: 30);
		position: 100 @ 100;
		effect: (BlDropShadowEffect color: Color black width: 15 offset: 0).
	parent := BlElement new
		extent: 400 @ 400;
		background: Color blue;
		effect: (BlDropShadowEffect color: Color black width: 10 offset: 0);
		position: 100 @ 100;
		addChild: el.
	BlSpace new
		rootDo: [ :r | 
			r
				addChild: parent;
				addChild: (self layoutBoundsOf: el in: r);
				addChild: (self fxBoundsOf: el in: r);
				addChild: (self txBoundsOf: el in: r);
				addChild: (self geomBoundsOf: el in: r);
				addChild: (self innerBoundsOf: el in: r) ];
		show