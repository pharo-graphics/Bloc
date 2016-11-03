as yet unclassified
initialize
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color white darker.
	self height: 14.
	self constraintsDo: [ :c| c horizontal matchParent  ].
	self addChild: self createDateEl 