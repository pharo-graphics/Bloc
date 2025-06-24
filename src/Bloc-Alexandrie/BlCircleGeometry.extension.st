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
BlCircleGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [

	aBlGradientShadowEffect setUpCircle: radius
]
