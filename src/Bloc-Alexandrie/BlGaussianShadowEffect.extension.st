Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	| alphaSurface shadowSpace visualBounds |
	shadowSpace := self extraShadowSpace.
	visualBounds := aBlElement visualBounds.

	alphaSurface := aeCanvas
		newSurfaceWithGaussianShadow: visualBounds extent + (shadowSpace * 2)
		width: width
		canvasDo: [ :alphaCanvas |
			alphaCanvas pathTranslate: shadowSpace asPoint.
			aBlElement aeDrawGeometryOn: alphaCanvas ].
	
	aeCanvas
		maskSurface: alphaSurface
			x: offset x - shadowSpace
			y: offset y - shadowSpace
			color: color
]
