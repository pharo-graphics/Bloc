initialization
initialize
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	
	list := BlInfiniteExamplePagerElement new.
	
	list constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	buttonLeft := BlTextElement new
		padding: (BlInsets all: 10);
		background: Color veryLightGray;
		text: (BlRopedText string: '< Left');
		addEventHandlerOn: BlClickEvent do: [ :anEvent |
			list smoothScrollBy: list width negated @ 0 ].
	buttonRight := BlTextElement new
		padding: (BlInsets all: 10);
		background: Color veryLightGray;
		text: (BlRopedText string: 'Right >');
		addEventHandlerOn: BlClickEvent do: [ :anEvent |
			list smoothScrollBy: list width @ 0 ].

	self addChildren: { buttonLeft . list . buttonRight }