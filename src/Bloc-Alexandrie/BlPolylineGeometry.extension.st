Extension { #name : 'BlPolylineGeometry' }

{ #category : '*Bloc-Alexandrie' }
BlPolylineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		"Cairo treats first lineTo: as a moveTo:"
		vertices do: [ :each | cairoContext lineTo: each ] ]

]
