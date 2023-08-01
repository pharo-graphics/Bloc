"
I'm a `BlElement` composition layer, that cache rasterization when the element's compositingMode requires it, i.e. when the element responds true to wantsSeparateCompositingLayer.

"
Class {
	#name : #BAAxisAlignedCompositionLayer,
	#superclass : #Object,
	#instVars : [
		'offset',
		'surface',
		'element',
		'pattern'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #'instance creation' }
BAAxisAlignedCompositionLayer class >> newFor: aBlElement [

	^ self basicNew
		initializeFor: aBlElement;
		yourself
]

{ #category : #'*Bloc-Alexandrie' }
BAAxisAlignedCompositionLayer >> createSurfaceToBePaintedOn: aCanvas [

	| scale |
	scale := aCanvas privateAeCairoSurface deviceScale.
	surface := AeCairoImageSurface extent: element invalidationBoundsInSpace extent * scale.
	surface deviceScale: scale.

	"The pattern allows us to establish a sampling filter that's not fancy,
	and would make it blurry (note the draw already has antialiasing)."
	pattern := AeCairoSurfacePattern surface: surface.
	pattern filter: AeCairoSamplingFilter CAIRO_FILTER_FAST.

	"offset := element invalidationBounds origin."
	self drawOn: (AeCanvas newFor: surface).
	
"	Time primMillisecondClock trace.
	' CREATE ' trace.
	element id traceCr."
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

{ #category : #accessing }
BAAxisAlignedCompositionLayer >> ensureReadyToPaintOn: aCanvas [
	"Ensure I'm ready to paint"

	self isValid
		ifTrue: [
			element needsPaint ifTrue: [
				self updateSurfaceToBePaintedOn: aCanvas ] ]
		ifFalse: [
			"First time, and after re-opening image."
			self createSurfaceToBePaintedOn: aCanvas ]

]

{ #category : #initialization }
BAAxisAlignedCompositionLayer >> initializeFor: aBlElement [

	self initialize.
	
	element := aBlElement
]

{ #category : #testing }
BAAxisAlignedCompositionLayer >> isValid [

	^ surface notNil and: [ surface isNull not ]
]

{ #category : #accessing }
BAAxisAlignedCompositionLayer >> paintOn: aCanvas [ 
	"Ensure the surface was drawn (with its transformation stack), "

	self ensureReadyToPaintOn: aCanvas.

	aCanvas restoreContextAfter: [
		"Apply clip in parent chain."
		element withAllParentsReverseDo: [ :each |
			aCanvas pathTranslate: each position.
			each transformation aeApplyTo: aCanvas.
			each == element ifFalse: [
				(each clipChildren and: [ each hasChildren ]) ifTrue: [
					each geometry aeApplyTo: aCanvas element: each.
					aCanvas preparePathAndClip ] ] ].

		"The layer has a global position"
		aCanvas privateAeCairoContext setIdentityMatrix.
		aCanvas pathTranslate: element invalidationBoundsInSpace origin.

		"Paint the layer"
		aCanvas privateAeCairoContext
			source: pattern;
			paintWithAlpha: element opacity ]
]

{ #category : #printing }
BAAxisAlignedCompositionLayer >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (self isValid
			ifTrue: [ 'VALID' ]
			ifFalse: [ 'INVALID' ]);
		space;
		print: element;
		nextPut: $)
]

{ #category : #removing }
BAAxisAlignedCompositionLayer >> removeFromParent [
	"This layer is being detached from it's element"

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
