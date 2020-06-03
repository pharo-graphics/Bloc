Extension { #name : #BlElementEffect }

{ #category : #'*Bloc-Compositor' }
BlElementEffect >> paintAfterOn: aCompositorPainter for: anElement [
]

{ #category : #'*Bloc-Compositor' }
BlElementEffect >> paintBeforeOn: aCompositorPainter for: anElement [
]

{ #category : #'*Bloc-Compositor' }
BlElementEffect >> paintEffectOn: aCompositorPainter for: anElement around: aBlock [
	
	self paintBeforeOn: aCompositorPainter for: anElement.
	aBlock value: aCompositorPainter.
	self paintAfterOn: aCompositorPainter for: anElement
]

{ #category : #'*Bloc-Compositor' }
BlElementEffect >> paintOn: aCompositorPainter offset: anOffset for: anElement thenPaint: aBlock [
	aBlock cull: aCompositorPainter cull: anOffset
]
