as yet unclassified
initialize
	super initialize.
	self geometry: BlEllipse new.
	self background: self createGradientPaint.
	self border: (BlBorder 
		color: Color black lighter 
		width: (BlMobilePhone pxCameraDiameter * 0.2) asInteger).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self extent:  BlMobilePhone pxCameraDiameter asPoint