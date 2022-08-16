Extension { #name : #BlEllipseGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlEllipseGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext | 
		| rect |
		rect := self geometryBounds.
		cairoContext
			ellipseWidth: rect width
			height: rect height ]
]
