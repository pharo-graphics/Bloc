Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Compositor' }
BlGaussianShadowEffect >> paintOn: aCompositorPainter offset: anOffset for: anElement thenPaint: aBlock [
	aCompositorPainter
		pushShadow: (anElement geometry pathOnSpartaCanvas: aCompositorPainter canvas of: anElement)
		shadowOffset: offset
		shadowColor: color
		shadowWidth: width
		offset: anOffset
		bounds: anElement invalidationBounds
		compositing: BlCompositingSeparateLayerMode uniqueInstance
		thenPaint: aBlock
]
