Extension { #name : #BlCircleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: false
		hasCaps: false
		block: [ :cairoContext | 
			cairoContext
				circleCenterX: self origin x
				y: self origin y
				radius: self radius ]
]
