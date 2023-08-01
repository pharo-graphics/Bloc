Extension { #name : #BAAxisAlignedCompositionLayer }

{ #category : #'*Bloc-Alexandrie' }
BAAxisAlignedCompositionLayer >> createSurfaceToBePaintedOn: aCanvas [

	| scale |
	scale := aCanvas privateAeCairoSurface deviceScale.
	surface := AeCairoImageSurface extent: element invalidationBoundsInSpace extent * scale.
	surface deviceScale: scale.

	"The pattern allows us to establish a sampling filter that's not fancy,
	and would make it blurry (note the draw already has antialiasing)."
	pattern := AeCairoSurfacePattern surface: surface.
	pattern filter: AeCairoSamplingFilter fast.

	"offset := element invalidationBounds origin."
	self drawOn: (AeCanvas newFor: surface).
	
	Time primMillisecondClock trace.
	' CREATE ' trace.
	element id traceCr.
]

{ #category : #'*Bloc-Alexandrie' }
BAAxisAlignedCompositionLayer >> drawOn: layerCanvas [
	"We assume the layer exists and isValid, and it's surface is clean."

	layerCanvas pathTranslate: element invalidationBoundsInSpace origin negated.
	element withAllParentsReverseDo: [ :each |
		layerCanvas pathTranslate: each position.
		each transformation aeApplyTo: layerCanvas ].

	element aeDrawIgnoringOpacityAndTransformationOn: layerCanvas.

	layerCanvas flush.

	element markDoesNotNeedPaint.

"	surface asFormA8  inspect."
]

{ #category : #'*Bloc-Alexandrie' }
BAAxisAlignedCompositionLayer >> updateSurfaceToBePaintedOn: aCanvas [
	"We assume the layer exists and isValid, but needs refresh."

	| layerCanvas |
	"In fact it only updates if extents match"	
	surface extent = (element invalidationBoundsInSpace extent
		* aCanvas privateAeCairoSurface deviceScale) ifFalse: [
			^ self createSurfaceToBePaintedOn: aCanvas ].
	
	"offset := element invalidationBounds origin."
	layerCanvas := AeCanvas newFor: surface.
	layerCanvas clearTransparent.
	self drawOn: layerCanvas.

"	Time primMillisecondClock trace.
	' UPDATE ' trace.
	element id traceCr.
"
]
