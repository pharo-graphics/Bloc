Class {
	#name : #BlCompositionBufferedPainter,
	#superclass : #BlCompositionPainter,
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #converting }
BlCompositionBufferedPainter >> asBufferedPainter [
	^ self
]

{ #category : #'api - layer' }
BlCompositionBufferedPainter >> pushChildren: theChildren offset: anOffset compositing: aBlCompositingMode thenPaint: aBlock [
	theChildren do: [ :eachChild | aBlock cull: eachChild cull: self cull: anOffset ]
]

{ #category : #'api - layer' }
BlCompositionBufferedPainter >> pushClip: aClipPath offset: anOffset bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	self applyClip: aClipPath offset: anOffset thenPaint: aPaintBlock
]

{ #category : #'api - layer' }
BlCompositionBufferedPainter >> pushShadow: aShadowPath shadowOffset: aShadowOffset shadowColor: aShadowColor shadowWidth: aShadowWidth offset: anOffset bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	
	self
		applyShadow: aShadowPath
		shadowOffset: aShadowOffset 
		shadowColor: aShadowColor
		shadowWidth: aShadowWidth
		offset: anOffset
		thenPaint: aPaintBlock
]

{ #category : #'api - layer' }
BlCompositionBufferedPainter >> pushTransform: aMatrix offset: anOffset bounds: aRectangleOrNull compositing: aBlCompositingMode thenPaint: aPaintBlock [

	self
		applyTransform: aMatrix
		offset: anOffset
		thenPaint: aPaintBlock
]

{ #category : #testing }
BlCompositionBufferedPainter >> shouldCreateNewLayer: wantsCompositionLayer [
	^ false
]
