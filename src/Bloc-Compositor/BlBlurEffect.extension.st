Extension { #name : #BlBlurEffect }

{ #category : #'*Bloc-Compositor' }
BlBlurEffect >> paintOn: aCompositorPainter offset: anOffset for: anElement thenPaint: aBlock [
	aBlock cull: aCompositorPainter cull: anOffset
]
