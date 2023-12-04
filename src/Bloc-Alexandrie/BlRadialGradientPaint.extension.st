Extension { #name : 'BlRadialGradientPaint' }

{ #category : '*Bloc-Alexandrie' }
BlRadialGradientPaint >> aeApplyTo: aeCanvas [
	"Apply self as a border to the canvas"

	aeCanvas
		setSourceRadialPatternStops: stops
		innerCenter: innerCenter
		innerRadius: innerRadius
		outerCenter: outerCenter
		outerRadius: outerRadius
]
