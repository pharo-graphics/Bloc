Extension { #name : #BlCircleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas
		setPathKey: self
		hasJoins: false
		hasCaps: false
		block: [ :cairoContext | 
			cairoContext
				primArcCenterX: self origin x + self radius
				centerY: self origin y + self radius
				radius: self radius
				startAngle: 0.0
				endAngle: Float twoPi ]
]
