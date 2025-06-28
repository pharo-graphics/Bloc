Extension { #name : #BlTriangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlTriangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		| thePoints |
		thePoints := self computeVertices.

		cairoContext
			moveTo: thePoints first;
			lineTo: thePoints second;
			lineTo: thePoints third;
			closePath ]

]

{ #category : #'*Bloc-Alexandrie' }
BlTriangleGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [

	aBlGradientShadowEffect
		setUpPolygon: self computeVertices
		extent: aPoint
]
