Extension { #name : #BlCubicBezierCommand }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlCubicBezierCommand >> aeApplyOn: cairoContext [

	cairoContext
		curveVia: from
		via: controlPoint
		to: to
]
