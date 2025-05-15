"
I'm a `BlElement` composition layer, that caches an element's rasterization.

Basically, when an element has to draw itself on a canvas and responds true to `wantsSeparateCompositingLayer`, then it's drawn in a new Cairo surface, and then ""painted"" into the host space canvas. Next pulse with drawing phase needed, if the element wasn't invalidated, the Cairo surface will be painted again into the host space canvas without need to redraw again.

There are two strategies for doing it:

* `beInSingleCompositionLayer`, that caches itself and all recursive children in a single surface (it doesn't matter if any of the children have one of these options)
* `beInSeparateCompositionLayer`, that is similar to previous option but any children can be cached separately.

Note: Element effect's have wantsCompositionLayer on their API, which the element queries to decide if it has a composition layer. For example, BlGaussianShadowEffect answers true.
"
Class {
	#name : #BAAxisAlignedCompositionLayer,
	#superclass : #Object,
	#instVars : [
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

{ #category : #drawing }
BAAxisAlignedCompositionLayer >> createSurfaceToBePaintedOn: aCanvas [

	| scale layerCanvas logicalBounds |
	scale := aCanvas deviceScale.
	logicalBounds := element invalidationBoundsInSpace.
	surface := AeCairoImageSurface extent: logicalBounds extent * scale.
	surface deviceScale: scale.

	"The pattern allows us to establish a sampling filter that's not fancy,
	and would make it blurry (note the draw already has antialiasing)."
	pattern := AeCairoSurfacePattern surface: surface.
	pattern filter: AeCairoSamplingFilter fast.

	layerCanvas := AeCanvas newFor: surface.
	layerCanvas clippingRectangle: logicalBounds.
	element aeDrawAsSeparatedLayerOn: layerCanvas.
	layerCanvas flush
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

	| logicalBounds |
	logicalBounds := element invalidationBoundsInSpace.
	(logicalBounds intersects: aCanvas clippingRectangle)
		ifFalse: [ ^ self ].


	self ensureReadyToPaintOn: aCanvas.

	aCanvas restoreContextAfter: [
		"Apply clip in parent chain."
		element aeApplyClippingWithAllParentsOn: aCanvas.

		"The layer has a global position"
		aCanvas
			setIdentityMatrix;
			pathTranslate: logicalBounds origin.

		"Paint the layer"
		aCanvas paint: pattern alpha: element opacity ]
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

{ #category : #drawing }
BAAxisAlignedCompositionLayer >> updateSurfaceToBePaintedOn: aCanvas [
	"We assume the layer exists and isValid, but needs to refresh its pixels."

	| layerCanvas logicalBounds |
	"In fact it only updates if extents match"	
	logicalBounds := element invalidationBoundsInSpace.
	surface extent = (logicalBounds extent * aCanvas deviceScale) asIntegerPoint
		ifFalse: [ ^ self createSurfaceToBePaintedOn: aCanvas ].
	
	layerCanvas := AeCanvas newFor: surface.
	layerCanvas clippingRectangle: logicalBounds.
	layerCanvas clearTransparent. "We need to clean it up"
	element aeDrawAsSeparatedLayerOn: layerCanvas.
	layerCanvas flush
]
