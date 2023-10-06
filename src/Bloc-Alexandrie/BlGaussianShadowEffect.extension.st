Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> aeDrawInset: aBlElement on: aeCanvas [

"	| aeContext |
	aeContext := aeCanvas privateAeCairoContext.

	aeCanvas maskGroupWith: [
		aBlElement geometry
			aeApplyTo: aeCanvas
			element: aBlElement.
		aeCanvas setSourceColor: color.
		aeCanvas drawFigureAndPrepareToClip: true.
		aeContext setOperatorClear.
		aeCanvas pathTranslate: offset.
		aBlElement aeDrawGeometryOn: aeCanvas ].
"
	| aeContext visualBounds alphaSurface alphaCanvas |
	aeContext := aeCanvas privateAeCairoContext.	
	visualBounds := aBlElement visualBounds.
	alphaSurface := aeContext surface
		newSimilarImageFormat: AeCairoSurfaceFormat a8
		width: visualBounds width
		height: visualBounds height.
	alphaSurface status ensureIsSuccess.

	alphaCanvas := AeCanvas newFor: alphaSurface.
	alphaCanvas pathTranslate: offset.
	aeContext
		sourceColorRGBA: color;
		paint;
		setOperatorClear.
	aBlElement aeDrawGeometryOn: alphaCanvas.

	alphaSurface flush.

"
	
	aeCanvas privateAeCairoContext
		sourceColorRGBA: color;
		maskSurface: alphaSurface
			x: offset x - shadowSpace
			y: offset y - shadowSpace.

"


"	| aeContext |
	aeContext := aeCanvas privateAeCairoContext.
1halt.	
	aeCanvas restoreContextAfter: [
		aBlElement geometry
			aeApplyTo: aeCanvas element: aBlElement.
		aeCanvas setSourceColor: color.
		aeCanvas drawFigureAndPrepareToClip: false.
"
"		aeContext
			clip;
			sourceColorRGBA: color;
			paint.
			
		aeCanvas maskGroupWith: [
			aeCanvas privateAeCairoContext setOperatorClear.
			aeCanvas pathTranslate: offset.
			aBlElement aeDrawGeometryOn: aeCanvas ]" 
		
		


]

{ #category : #'*Bloc-Alexandrie' }
BlGaussianShadowEffect >> aeDrawOutset: aBlElement on: aeCanvas [

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
		sourceColorRGBA: color;
		maskSurface: alphaSurface
			x: offset x - shadowSpace
			y: offset y - shadowSpace.

]
