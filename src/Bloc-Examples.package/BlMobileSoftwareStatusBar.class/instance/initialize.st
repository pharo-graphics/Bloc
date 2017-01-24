initialization
initialize
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color white darker.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 18 ].
	self addChild: self createDateEl 