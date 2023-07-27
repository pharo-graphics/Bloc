Extension { #name : #BlRadialGradientPaint }

{ #category : #'*Bloc-Alexandrie' }
BlRadialGradientPaint >> aeApplyTo: aeCanvas [
	"Apply self as a border to the canvas"

	aeCanvas
		setSourceRadialPatternStops: stops
		center: center
		radius: radius
]
