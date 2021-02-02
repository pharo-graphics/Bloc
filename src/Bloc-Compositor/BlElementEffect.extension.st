Extension { #name : #BlElementEffect }

{ #category : #'*Bloc-Compositor' }
BlElementEffect >> paintOn: aCompositorPainter offset: anOffset for: anElement thenPaint: aBlock [

	aCompositorPainter canvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [  self applyBeforeOnSpartaCanvas: aCompositorPainter canvas for: anElement ].

	aBlock cull: aCompositorPainter cull: anOffset.
	
	aCompositorPainter canvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [ self applyAfterOnSpartaCanvas: aCompositorPainter canvas for: anElement ]
]
