Extension { #name : #BlNullEffect }

{ #category : #'*Bloc-Compositor' }
BlNullEffect >> paintOn: aCompositorPainter offset: anOffset for: anElement thenPaint: aBlock [
	aBlock cull: aCompositorPainter cull: anOffset
]
