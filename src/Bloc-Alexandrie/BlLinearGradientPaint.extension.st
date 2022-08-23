Extension { #name : #BlLinearGradientPaint }

{ #category : #'*Bloc-Alexandrie' }
BlLinearGradientPaint >> aeApplyTo: aeCanvas opacity: backgroundOpacity [

	aeCanvas
		setBackgroundWith: [ 
			aeCanvas
				setSourceLinearPatternStops: stops
				start: start
				end: end ]
		alpha: backgroundOpacity
]
