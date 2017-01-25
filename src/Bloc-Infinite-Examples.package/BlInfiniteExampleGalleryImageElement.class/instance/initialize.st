initialization
initialize
	super initialize.

	self background: Color veryVeryDarkGray lighter.
	
	itemElement := BlTextElement new
		geometry: BlEllipse new;
		background: (Color gray alpha: 0.4);
		border: (BlBorder paint: (Color white alpha: 0.2) width: 1);
		effect: (BlBlurBelowEffect radius: 2);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c frame vertical alignCenter.
			c padding: (BlInsets all: 10) ];
		yourself.
	
	self padding: (BlInsets left: 20).
	self addChild: itemElement