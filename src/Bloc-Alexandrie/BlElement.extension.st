Extension { #name : #BlElement }

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeApplyClippingWithAllParentsOn: aCanvas [
	"Apply clipping in the whole parent chain"

	self withAllParentsReverseDo: [ :each |
		aCanvas pathTranslate: each position.
		each transformation aeApplyTo: aCanvas.
		each == self ifFalse: [
			(each clipChildren and: [ each hasChildren ]) ifTrue: [
				each geometry aeApplyTo: aCanvas element: each.
				aCanvas preparePathAndClip ] ] ]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeAsForm [

	| invalidationBounds aCanvas |
	self isLayoutRequested ifTrue: [ self forceLayout ].

	"We want to consider our border, effect, as well as children's."
	invalidationBounds := self invalidationBoundsInParent.
	aCanvas := AeCanvas extent: invalidationBounds extent.
	aCanvas pathTranslate: invalidationBounds origin negated.

	self aeFullDrawOn: aCanvas.
	^ aCanvas asForm
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeCompositionLayersSortedByElevationDo: aBlock [

	(self isTransparent or: [ self isVisible not ])
		ifTrue: [ ^ self ].

	self wantsSeparateCompositingLayer ifTrue: [
		self hasCompositionLayer ifFalse: [
			self compositionLayer:
				(BAAxisAlignedCompositionLayer newFor: self) ].
		aBlock value: self compositionLayer ].

	self flag: #todo. "extract to allow overriding, exactly as aeDrawChildrenOn:"
	self children sortedByElevation do: [ :each |
		(each aeCompositionLayersSortedByElevationDo: aBlock) ]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawAsSeparatedLayerOn: layerCanvas [
	"We assume the layer exists and isValid, and it's surface is clean."

	layerCanvas pathTranslate: self invalidationBoundsInSpace origin negated.
	self withAllParentsReverseDo: [ :each |
		layerCanvas pathTranslate: each position.
		each transformation aeApplyTo: layerCanvas ].

	self aeDrawIgnoringOpacityAndTransformationOn: layerCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawChildrenOn: aeCanvas [
	"Draw my children that belong to same composition layer.
	
	Notes:
	- Receiver assumes that position and transformations are already applied on the canvas."
	
	self children sortedByElevation do: [ :each |
		each aeDrawInSameLayerOn: aeCanvas ].
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
BlElement >> aeDrawIgnoringOpacityAndTransformationOn: aeCanvas [

	self aeDrawEffectBelowGeometryOn: aeCanvas.
	self aeDrawGeometryOn: aeCanvas.
	self aeDrawEffectAboveGeometryOn: aeCanvas.
	self aeDrawChildrenOn: aeCanvas.

	self markDoesNotNeedPaint
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawInSameLayerOn: aCanvas [

	(self isTransparent not and: [
	self isVisible and: [
	self wantsSeparateCompositingLayer not ] ])
		ifTrue: [ self aeDrawOn: aCanvas ]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeDrawOn: aeCanvas [

	(self invalidationBoundsInSpace intersects: aeCanvas clippingRectangle) ifFalse: [ ^self ].
	boundsCache markLastDrawBounds.
	
	aeCanvas
		restoreContextAfterPaintAlpha: self opacity
		with: [ "My position is applied before my transformation matrix,
			which may have an additional translation."
			aeCanvas pathTranslate: self position.
			self transformation aeApplyTo: aeCanvas.
			self aeDrawIgnoringOpacityAndTransformationOn: aeCanvas ]
]

{ #category : #'*Bloc-Alexandrie' }
BlElement >> aeFullDrawOn: aCanvas [
	"Main entry point to draw myself and my children on an Alexandrie canvas."

	self aeDrawInSameLayerOn: aCanvas.

	self aeCompositionLayersSortedByElevationDo: [ :each | each paintOn: aCanvas ]
]
