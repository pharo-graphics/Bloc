Extension { #name : 'BlRadialGradientPaint' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlRadialGradientPaint >> newCairoPattern [

	^ AeCairoRadialGradientPattern
			innerCenter: center
			innerRadius: 0.0
			outerCenter: center
			outerRadius: radius
			addStopsFrom: stops
]
