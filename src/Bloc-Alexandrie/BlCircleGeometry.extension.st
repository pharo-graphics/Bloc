Extension { #name : #BlCircleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext | 
		cairoContext circleRadius: self radius ]
]
