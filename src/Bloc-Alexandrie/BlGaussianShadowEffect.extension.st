Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	| alphaSurface alphaCanvas shadowSpace |
	shadowSpace := self extraShadowSpace.
	alphaSurface := aeCanvas privateAeCairoContext surface
		newSimilarImageFormat: AeCairoSurfaceFormat CAIRO_FORMAT_A8
		width: (aBlElement visualBounds width + (shadowSpace * 2))
		height: (aBlElement visualBounds height + (shadowSpace * 2)).
	alphaSurface status ensureIsSuccess.

	alphaCanvas := AeCanvas newFor: alphaSurface.
	alphaCanvas pathTranslate: shadowSpace asPoint.
	aBlElement aeDrawGeometryOn: alphaCanvas.
	alphaSurface flush.

	AeCairoA8FastGaussianBlurFilter new
		surface: alphaSurface;
		applyRadius: width.
	
	aeCanvas privateAeCairoContext
		sourceColorRGBA: color;
		maskSurface: alphaSurface
			x: offset x - shadowSpace
			y: offset y - shadowSpace.

]
