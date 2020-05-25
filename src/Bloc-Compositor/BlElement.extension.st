Extension { #name : #BlElement }

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintCompositedOn: aCompositorPainter offset: anOffset [
	| aLayer |

	needsPaint
		ifTrue: [
			| anOffsetLayer |
			
			anOffsetLayer := BlCompositionOffsetLayer new
				creatorElement: self;
				offset: anOffset.
			
			aCompositorPainter
				pushLayer: anOffsetLayer
				offset: 0@0
				bounds: self invalidationBounds
				thenPaint: [ :aChildPainter :aChildOffset |
					self fullPaintWithOpacityOn: aChildPainter offset: aChildOffset.
					aChildPainter stopRecording ].
				self userData at: #compositionLayer put: anOffsetLayer ].
	
	aLayer := self userData at: #compositionLayer.
		
	self
		assert: [ aLayer isKindOf: BlCompositionOffsetLayer ]
		description: [ 'Must be offset layer' ].
		
	aLayer offset: anOffset.
	aLayer removeFromParent.
	aCompositorPainter addLayer: aLayer
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintOn: aCompositorPainter offset: anOffset [
	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ aCompositorPainter ].

	(aCompositorPainter shouldCreateNewLayer: self wantsCompositionLayer) 
		ifTrue: [	 self fullPaintCompositedOn: aCompositorPainter offset: anOffset + self position ]
		ifFalse: [ self fullPaintWithOpacityOn: aCompositorPainter offset: anOffset + self position ].

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
		ifTrue: [ self paintMeAndChildrenOn: aCompositorPainter offset: anOffset ]
		ifFalse: [
			(self transformation isPureTranslation)
				ifTrue: [
					| aTranslation |
					aTranslation := self transformation transformPoint: 0@0.
					self paintMeAndChildrenOn: aCompositorPainter offset: anOffset + aTranslation ]
				ifFalse: [
					aCompositorPainter
						pushTransform: self transformation matrix
						offset: anOffset
						compositing: self wantsCompositionLayer
						bounds: self invalidationBounds
						from: self
						thenPaint: [ :aTransformCompositorPainter :aTransformOffset |
							self paintMeAndChildrenOn: aTransformCompositorPainter offset: aTransformOffset ] ] ]
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
		during: [ self drawOnSpartaCanvas: aCanvas ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> wantsCompositionLayer [
	^ false
]
