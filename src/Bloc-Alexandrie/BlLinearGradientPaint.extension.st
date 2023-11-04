Extension { #name : #BlLinearGradientPaint }

{ #category : #'*Bloc-Alexandrie' }
BlLinearGradientPaint >> aeApplyTo: aeCanvas [
	"Apply self as a border to the canvas"

	aeCanvas
		setSourceLinearPatternStops: stops
		start: start
		end: end
]
