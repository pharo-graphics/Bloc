initialization
initialize
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical fitContent.
		c padding: (BlInsets all: 5) ].
	
	self border:(BlBorder paint: Color black width: 2).
	self background: (Color white alpha: 0.9).
	
	fpsShape := BlTextElement new.
	fpsShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].
	renderTimeShape := BlTextElement new.
	renderTimeShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].
	eventProcessingShape := BlTextElement new.
	eventProcessingShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].
	layoutingShape := BlTextElement new.
	layoutingShape constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 2) ].

	self
		layout: (BlLinearLayout vertical);
		addChild: fpsShape;
		addChild: renderTimeShape