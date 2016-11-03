as yet unclassified
createGradientPaint
	^ BlLinearGradientPaint new
		stops: { 
		0.0 -> (Color white alpha:0.7).
		0.30 -> (Color veryDarkGray alpha:0.3).
		0.60 -> (Color veryDarkGray alpha:0.3).
		1.0 -> (Color white alpha:0.7) };
		start: 0@BlMobilePhone pxHomeButtonDiameter;
		end: BlMobilePhone pxHomeButtonDiameter@0;
		yourself