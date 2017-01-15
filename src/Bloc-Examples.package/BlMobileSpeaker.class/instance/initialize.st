initialization
initialize
	super initialize.
	self background: Color black lighter.
	self border: (BlBorder paint: self createGradientPaint width: 2).
	self margin: (BlInsets top: 5).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self size:  BlMobilePhone pxSpeakerWidth @ BlMobilePhone pxSpeakerHeight