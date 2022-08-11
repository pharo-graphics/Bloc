Extension { #name : #BlEllipseGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlEllipseGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: false
		hasCaps: false
		block: [ :cairoContext | 
			| rect |
			rect := self geometryBounds.
			cairoContext
				ellipseWidth: rect width
				height: rect height ]
]
