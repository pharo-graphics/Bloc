as yet unclassified
initialize
	super initialize.
	self background: (BlImagePatternPaint form: self class backgroundForm).
	
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self addChild: BlMobileSoftwareStatusBar new