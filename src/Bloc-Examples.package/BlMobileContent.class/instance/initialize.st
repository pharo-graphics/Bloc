as yet unclassified
initialize
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color black.
	self border: (BlBorder color: self createGradientPaint width: 2 radius: 30).
	self constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self
		addChild: self createTopEl;
		addChild: self createScreenEl;
		addChild: self createBottomEl