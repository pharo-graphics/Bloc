Extension { #name : #BlElement }

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeAsForm [

	| aCanvas |
	self isLayoutRequested
		ifTrue: [ self forceLayout ].

	aCanvas := AeCanvas extent: self extent.
	aCanvas fullDraw: self.
	^ aCanvas asForm

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeCreateCompositionLayer [

	| theBounds |
	theBounds := self invalidationBounds.
 	self compositionLayer: 
		(BACompositionLayer new
			surface: (AeCairoImageSurface extent: theBounds extent);
			offset: theBounds origin;
			yourself).

	self aeDrawOnCompositionLayerCleanBefore: false.
	
	self trace.
	'-> layer created' traceCr
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawChildrenOn: aeCanvas [
	"Draw my children.
	
	Notes:
	- Receiver assumes that position and transformations are already applied on the canvas."
	
	self children sortedByElevation do: [ :each |
		each aeFullDrawOn: aeCanvas ].
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawEffectAboveGeometryOn: aeCanvas [

	self effect aeDrawAbove: self on: aeCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawEffectBelowGeometryOn: aeCanvas [

	self effect aeDrawBelow: self on: aeCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawGeometryOn: aeCanvas [
	"Draw my geometry with the corresponding background and border.

	Notes:
	- AeCanvas requires background to be set up first (see class comment).
	- Pre-condition: position and transformations are already applied on the canvas.
	- Post-condition: position and transformations are maintanined intact."
	
	| myBackground |
	self geometry aeApplyTo: aeCanvas element: self.

	myBackground := self background.
	myBackground isTransparent
		ifTrue: [ aeCanvas setBackgroundOff ]
		ifFalse: [ myBackground aeApplyTo: aeCanvas ].

	"Border may set stroke options, outskirts and geometry's border path"
	self border aeApplyTo: aeCanvas element: self.

	aeCanvas drawFigureAndPrepareToClip: (self hasChildren and: [ self clipChildren ]).

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas [

	self aeDrawOn: aeCanvas with: [

		"My position is applied before my transformation matrix,
		which may have an additional translation."
		aeCanvas pathTranslate: self position.
		self transformation aeApplyTo: aeCanvas.

		self aeDrawEffectBelowGeometryOn: aeCanvas.
		self aeDrawGeometryOn: aeCanvas.
		self aeDrawEffectAboveGeometryOn: aeCanvas.

		self aeDrawChildrenOn: aeCanvas.
		
		]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas with: aBlockClosure [
	"Evaluate a block closure taking account my opacity.
	The element opacity affects border and background, effects, and 
	recursively to children elements.
	When I have opaque opacity (1.0) I take the fastest branch, restoring
	the Cairo caontext afterwards."

	self opacity < 1.0
		ifTrue: [ aeCanvas paintGroupWith: aBlockClosure alpha: self opacity ]
		ifFalse: [ aeCanvas restoreContextAfter: aBlockClosure ]

]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOnCompositionLayerCleanBefore: shouldClean [
	"We assume the layer exists and isValid, and it's surface is clean."

	| layer layerCanvas |
	layer := self compositionLayer.
	layerCanvas := AeCanvas newFor: layer surface.
	layerCanvas pathTranslate: layer offset negated.
	shouldClean ifTrue: [
		layerCanvas clearTransparent ].
	self
		aeDrawEffectBelowGeometryOn: layerCanvas;
		aeDrawGeometryOn: layerCanvas;
		aeDrawEffectAboveGeometryOn: layerCanvas;
		aeDrawChildrenOn: layerCanvas.
	layerCanvas flush
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeFullDrawOn: aCanvas [
	"Main entry point to draw myself and my children on an Alexandrie canvas."

	(self isTransparent or: [ self isVisible not ]) ifTrue: [
		^ self markDoesNotNeedPaint ].

	self wantsSeparateCompositingLayer
		ifFalse: [ self aeDrawOn: aCanvas ]
		ifTrue: [ self ensureLayerAndDrawOn: aCanvas ].
	
	self markDoesNotNeedPaint
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeUpdateCompositionLayer [
	"We assume the layer exists and isValid, but needs refresh."

	| layer theBounds |
	layer := self compositionLayer.
	theBounds := self invalidationBounds.

	"In fact it only updates if extents match"	
	layer surface extent = theBounds extent ifFalse: [ 
		^ self aeCreateCompositionLayer ].
	
	layer offset: theBounds origin.
	self aeDrawOnCompositionLayerCleanBefore: true.

	self trace.
	'-> layer updated' traceCr
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> ensureLayerAndDrawOn: aCanvas [

	| layer |
	"Ensure layer is ready"
	self hasCompositionLayer
		ifFalse: [
			self aeCreateCompositionLayer ]
		ifTrue: [
			self needsPaint ifTrue: [
				self aeUpdateCompositionLayer ] ].

	"Paint the layer on the canvas"
	layer := self compositionLayer.
	self aeDrawOn: aCanvas with: [
		aCanvas pathTranslate: self position.
		self transformation aeApplyTo: aCanvas.

		aCanvas privateAeCairoContext
			sourceSurface: layer surface
				x: layer offset x
				y: layer offset y;
			paint ]
]
