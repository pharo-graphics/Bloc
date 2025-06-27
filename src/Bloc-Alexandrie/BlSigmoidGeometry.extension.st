Extension { #name : #BlSigmoidGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlSigmoidGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext
			moveTo: from;
			curveVia: fromControl
				  via: toControl
				   to: to ]
]
