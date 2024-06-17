Extension { #name : #BlQuadraticBezierCommand }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlQuadraticBezierCommand >> aeApplyOn: cairoContext [

	cairoContext
		quadraticCurveFromCurrentPoint: from
		via: controlPoint
		to: to
]
