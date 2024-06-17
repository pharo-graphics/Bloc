Extension { #name : #BlEllipticalArcCommand }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlEllipticalArcCommand >> aeApplyOn: cairoContext [

	cairoContext restoreStateAfter: [
		"Rotate around center"
		cairoContext
			translateBy: center;
			rotateByRadians: phi;
			translateBy: center negated.

		"Inspired on: https://www.cairographics.org/cookbook/ellipses/"
		cairoContext
			translateBy: center - radiiPoint;
			scaleBy: radiiPoint.

		cairoContext
			arcCenter: 1.0 @ 1.0
	 			radius: 1.0
				startAngle: startAngle degreesToRadians
				sweep: sweepAngle degreesToRadians ].
]
