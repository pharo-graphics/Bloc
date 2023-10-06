Extension { #name : #BlSimpleShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlSimpleShadowEffect >> aeDrawInset: aBlElement on: aeCanvas [

	| aeContext |
	aeContext := aeCanvas privateAeCairoContext.

	aeCanvas maskGroupWith: [
		aeContext
			sourceColorRGBA: color;
			paint;
			setOperatorClear.
		
		aBlElement geometry
			aeApplyTo: aeCanvas
			element: aBlElement.
		aeCanvas drawFigureAndPrepareToClip: true.
		aeCanvas pathTranslate: offset.
		aBlElement aeDrawGeometryOn: aeCanvas ].

"	| aeContext visualBounds alphaSurface alphaCanvas |
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

	alphaSurface flush."

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
BlSimpleShadowEffect >> aeDrawOutset: aBlElement on: aeCanvas [

	aeCanvas setSourceColor: color.
	aeCanvas maskGroupWith: [
		aeCanvas pathTranslate: offset.
		aBlElement aeDrawGeometryOn: aeCanvas ]
]
