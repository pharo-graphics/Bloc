Extension { #name : #BlRadialGradientPaint }

{ #category : #'*Bloc-Alexandrie' }
BlRadialGradientPaint >> aeApplyTo: aeCanvas opacity: backgroundOpacity [

	aeCanvas
		setBackgroundWith: [ 
			aeCanvas
				setSourceRadialPatternStops: stops
				center: center
				radius: radius ]
		alpha: backgroundOpacity
]
