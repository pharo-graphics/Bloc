as yet unclassified
initialize
	super initialize.
	self border: (BlBorder color: Color veryLightGray width: 1).
	self background: (Color white).
	self effect: (BlDropShadowEffect new color: Color gray; width:2; offset:2@2)