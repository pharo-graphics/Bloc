Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	| alphaSurface alphaCanvas shadowSpace visualBounds |
	shadowSpace := self extraShadowSpace.
	visualBounds := aBlElement visualBounds.
	alphaSurface := aeCanvas privateAeCairoContext surface
		newSimilarImageFormat: AeCairoSurfaceFormat a8
		width: (visualBounds width + (shadowSpace * 2))
		height: (visualBounds height + (shadowSpace * 2)).
	alphaSurface status ensureIsSuccess.

	alphaCanvas := AeCanvas newFor: alphaSurface.
	alphaCanvas pathTranslate: shadowSpace asPoint.
	aBlElement aeDrawGeometryOn: alphaCanvas.
	alphaSurface flush.

	AeCairoA8FastGaussianBlurFilter new
		surface: alphaSurface;
		applyRadius: width.
	
	aeCanvas privateAeCairoContext
		sourceColor: color;
		maskSurface: alphaSurface
			x: offset x - shadowSpace
			y: offset y - shadowSpace.

]
