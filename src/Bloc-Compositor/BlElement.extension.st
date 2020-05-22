Extension { #name : #BlElement }

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintOn: aCompositorPainter offset: anOffset [
	<return: #BlCompositionPainter>

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ aCompositorPainter ].

	^  self wantsCompositionLayer
		ifTrue: [	
			aCompositorPainter
				pushOffset: anOffset + self position
				bounds: self invalidationBounds
				from: self
				thenPaint: [ :aChildPainter :aChildOffset |
					self fullPaintWithOpacityOn: aChildPainter offset: aChildOffset.
					aChildPainter stopRecording ] ]
		ifFalse: [ self fullPaintWithOpacityOn: aCompositorPainter offset: anOffset + self position ]
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintWithOpacityOn: aCompositorPainter offset: anOffset [
	<return: #BlCompositionPainter>

	"We do not draw transparent (opacity is zero) elements at all"
	self isTransparent
		ifTrue: [ ^ aCompositorPainter ].

	^ self isTranslucent
		ifTrue: [ aCompositorPainter
			pushOpacity: self opacity
			offset: anOffset
			bounds: self invalidationBounds
			from: self
			thenPaint: [ :anOpacityPainter :anOpacityOffset | self fullPaintWithTransformOn: anOpacityPainter offset: anOpacityOffset ] ]
		ifFalse: [ self fullPaintWithTransformOn: aCompositorPainter offset: anOffset ].
]

{ #category : #'*Bloc-Compositor' }
BlElement >> fullPaintWithTransformOn: aCompositorPainter offset: anOffset [
	<return: #BlCompositionPainter>
	
	^ self transformation isIdentity
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
	<return: #BlCompositionPainter>
	| aNextPainter |
	
	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ aCompositorPainter ].
	
	aNextPainter := aCompositorPainter.
	
	self children sortedByElevation
		do: [ :anElement | "aNextPainter := "anElement fullPaintOn: aNextPainter offset: anOffset ].

	^ aNextPainter
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintMeAndChildrenOn: aCompositorPainter offset: anOffset [	
	<return: #BlCompositionPainter>
	| aNextPainter |
	
	aNextPainter := self paintOn: aCompositorPainter offset: anOffset.

	^ self
		paintChildrenOn: aNextPainter
		offset: anOffset
]

{ #category : #'*Bloc-Compositor' }
BlElement >> paintOn: aCompositorPainter offset: anOffset [
	<return: #BlCompositionPainter>
	| aCanvas |
	
	aCanvas := aCompositorPainter canvas.
	aCanvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [ self drawOnSpartaCanvas: aCanvas ].
	
	^ aCompositorPainter
]

{ #category : #'*Bloc-Compositor' }
BlElement >> wantsCompositionLayer [
	^ false
]
