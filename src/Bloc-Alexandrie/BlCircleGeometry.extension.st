Extension { #name : #BlCircleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext | 
		cairoContext circleRadius: self radius ]
]

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	aeCanvas
		drawClosedCurvedPathWith: [ :cairoContext | 
			cairoContext circleRadius: radius ]
		borderPathWith: [ :cairoContext |
			cairoContext
				circleCenterX: radius
				y: radius
				radius: radius - (aWidth/2.0) ]
]

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	aeCanvas
		drawClosedCurvedPathWith: [ :cairoContext | 
			cairoContext circleRadius: radius ]
		borderPathWith: [ :cairoContext |
			cairoContext
				circleCenterX: radius
				y: radius
				radius: radius + (aWidth/2.0) ]
]
