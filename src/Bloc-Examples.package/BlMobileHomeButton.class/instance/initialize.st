as yet unclassified
initialize
	super initialize.
	self geometry: BlEllipse new.
	self background: Color black.
	self border: (BlBorder color: self createGradientPaint width: 3).
	self margin: (BlInsets top: BlMobilePhone pxHomeButtonTopMargin ).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self extent:  BlMobilePhone pxHomeButtonDiameter asPoint