Extension { #name : #BlCircleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext circleRadius: radius ]
]

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [

	aeCanvas borderPathFactory: [ :cairoContext |
		cairoContext
			circleCenterX: radius
			y: radius
			radius: radius - (aWidth / 2.0) ]
]

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [ 

	aeCanvas borderPathFactory: [ :cairoContext |
		cairoContext
			circleCenterX: radius
			y: radius
			radius: radius + (aWidth / 2.0) ]
]

{ #category : #'*Bloc-Alexandrie' }
BlCircleGeometry >> aeSetGradientShadowOn: aBlFastCircleShadowEffect extent: aPoint [

	aBlFastCircleShadowEffect setShadowForCircle: aPoint min / 2.0
]
