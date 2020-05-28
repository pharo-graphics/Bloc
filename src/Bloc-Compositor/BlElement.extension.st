Extension { #name : #BlElement }

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintCompositedOn: aCompositorPainter offset: anOffset [
	| aLayer |

	self shouldBePainted
		ifTrue: [
			| anOffsetLayer anAddedLayer |
			
			anOffsetLayer := BlCompositionOffsetLayer new offset: anOffset.
			
			anAddedLayer := aCompositorPainter
				pushLayer: anOffsetLayer
				offset: 0@0
				bounds: (self invalidationBounds)
				buffered: self wantsCompositionBufferLayer
				thenPaint: [ :aChildPainter :aChildOffset |
					aChildPainter needsCache: true.
					self paintMeAndChildrenOn: aChildPainter offset: aChildOffset.					
					aChildPainter stopRecording ].
				self userData at: #compositionLayer put: anAddedLayer ]
			ifFalse: [ aCompositorPainter stopRecording ].
	
	aLayer := self userData at: #compositionLayer.
		
	aLayer offset: anOffset.
	aLayer removeFromParent.
	aCompositorPainter addLayer: aLayer
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintMeAndChildrenOn: aCompositorPainter offset: anOffset [
	(aCompositorPainter shouldCreateNewLayer: self wantsCompositionLayer) 
		ifTrue: [	 self fullPaintCompositedOn: aCompositorPainter offset: anOffset ]
		ifFalse: [ self paintMeAndChildrenOn: aCompositorPainter offset: anOffset ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintOn: aCompositorPainter offset: anOffset [
	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [
			needsPaint := false.
			^ self ].
	
	(self width isZero or: [ self height isZero ])
		ifTrue: [
			needsPaint := false.
			^ self ].

	self fullPaintWithTransformOn: aCompositorPainter offset: anOffset + self position.

	needsPaint := false
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintWithOpacityOn: aCompositorPainter offset: anOffset [

	"We do not draw transparent (opacity is zero) elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	self isTranslucent
		ifTrue: [ aCompositorPainter
			pushOpacity: self opacity
			offset: anOffset
			bounds: self invalidationBounds
			from: self
			thenPaint: [ :anOpacityPainter :anOpacityOffset | self fullPaintWithTransformOn: anOpacityPainter offset: anOpacityOffset ] ]
		ifFalse: [ self fullPaintWithTransformOn: aCompositorPainter offset: anOffset ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintWithTransformOn: aCompositorPainter offset: anOffset [
	self transformation isIdentity
		ifTrue: [ self fullPaintMeAndChildrenOn: aCompositorPainter offset: anOffset ]
		ifFalse: [
			(self transformation isPureTranslation)
				ifTrue: [
					| aTranslation |
					aTranslation := self transformation transformPoint: 0@0.
					self fullPaintMeAndChildrenOn: aCompositorPainter offset: anOffset + aTranslation ]
				ifFalse: [
					aCompositorPainter
						pushTransform: self transformation matrix
						offset: anOffset
						bounds: self invalidationBounds
						compositing: self wantsCompositionLayer
						buffered: self wantsCompositionBufferLayer
						thenPaint: [ :aTransformCompositorPainter :aTransformOffset |
							self fullPaintMeAndChildrenOn: aTransformCompositorPainter offset: aTransformOffset ] ] ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintChildrenOn: aCompositorPainter offset: anOffset [
	
	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	self children sortedByElevation
		do: [ :anElement | anElement fullPaintOn: aCompositorPainter offset: anOffset ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintMeAndChildrenOn: aCompositorPainter offset: anOffset [
	self paintOn: aCompositorPainter offset: anOffset.

	self
		paintChildrenOn: aCompositorPainter
		offset: anOffset
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintOn: aCompositorPainter offset: anOffset [
	| aCanvas |
	
	aCanvas := aCompositorPainter canvas.
	aCanvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [
			self effect
				applyEffectOnSpartaCanvas: aCanvas
				for: self
				around: [ :anEffectCanvas | self drawOnSpartaCanvas: anEffectCanvas ] ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> shouldBePainted [
	<return: #Boolean>

	^ needsPaint or: [ (self userData includesKey: #compositionLayer) not ]
]
