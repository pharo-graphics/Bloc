Extension { #name : #BlLineGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlLineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext lineFrom: from to: to ]
]
