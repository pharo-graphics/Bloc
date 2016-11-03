as yet unclassified
initialize
	super initialize.
	self background: Color black lighter.
	self border: (BlBorder color: self createGradientPaint width: 2 radius: 5).
	self margin: (BlInsets top: 5).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self extent:  BlMobilePhone pxSpeakerWidth @ BlMobilePhone pxSpeakerHeight