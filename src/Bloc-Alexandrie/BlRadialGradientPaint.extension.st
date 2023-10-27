Extension { #name : 'BlRadialGradientPaint' }

{ #category : '*Bloc-Alexandrie' }
BlRadialGradientPaint >> aeApplyTo: aeCanvas [
	"Apply self as a border to the canvas"

	aeCanvas
		setSourceRadialPatternStops: stops
		innerCenter: center
		innerRadius: 0.0
		outerCenter: center
		outerRadius: radius
]
