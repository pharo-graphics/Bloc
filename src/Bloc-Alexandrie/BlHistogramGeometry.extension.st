Extension { #name : #BlHistogramGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlHistogramGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		"Cairo treats first lineTo: as a moveTo:"
		self vertices do: [ :each | cairoContext lineTo: each ].
		cairoContext closePath ]
]
