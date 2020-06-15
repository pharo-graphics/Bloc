Class {
	#name : #BlCompositionLayeredPainter,
	#superclass : #BlCompositionPainter,
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #converting }
BlCompositionLayeredPainter >> asBufferedPainter [
	^ BlCompositionBufferedPainter new
		containerLayer: containerLayer;
		pictureLayer: pictureLayer;
		canvas: canvas;
		bounds: bounds;
		state: state;
		needsCache: needsCache
]

{ #category : #'api - layer' }
BlCompositionLayeredPainter >> pushChildren: theChildren offset: anOffset compositing: aBlCompositingMode thenPaint: aBlock [	
	aBlCompositingMode wantsBufferedLayer
		ifTrue: [
			| aNewPainter |
			self stopRecording.
			aNewPainter := self asBufferedPainter.
			theChildren do: [ :eachChild | aBlock cull: eachChild cull: aNewPainter cull: anOffset ].
			aNewPainter stopRecording ]
		ifFalse: [ theChildren do: [ :eachChild | aBlock cull: eachChild cull: self cull: anOffset ] ]
]

{ #category : #'api - layer' }
BlCompositionLayeredPainter >> pushClip: aClipPath offset: anOffset bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	
	aBlCompositingMode wantsCompositionLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionClipLayer new
					path: aClipPath;
					offset: anOffset)
				offset: anOffset
				bounds: aRectangle
				compositing: false
				thenPaint: aPaintBlock ]
		ifFalse: [ self applyClip: aClipPath offset: anOffset thenPaint: aPaintBlock ]
]

{ #category : #'private - layer' }
BlCompositionLayeredPainter >> pushLayer: aNewLayer offset: anOffset bounds: aRectangleOrNull compositing: aBlCompositingMode thenPaint: aPaintBlock [
	| aNewPainter |
	
	self addLayer: aNewLayer.
	
	self stopRecording.

	aNewPainter := self class new
		containerLayer: aNewLayer;
		bounds: aRectangleOrNull;
		needsCache: true.
	 aPaintBlock cull: aNewPainter cull: anOffset.

	aNewPainter stopRecording
]

{ #category : #'api - layer' }
BlCompositionLayeredPainter >> pushShadow: aShadowPath shadowOffset: aShadowOffset shadowColor: aShadowColor shadowWidth: aShadowWidth offset: anOffset bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	
	aBlCompositingMode wantsCompositionLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionShadowLayer new
					offset: anOffset;
					shadowOffset: aShadowOffset;
					shadowColor: aShadowColor;
					shadowWidth: aShadowWidth;
					shadowPath: aShadowPath)
				offset: anOffset
				bounds: aRectangle
				compositing: false
				thenPaint: aPaintBlock ]
		ifFalse: [
			self
				applyShadow: aShadowPath
				shadowOffset: aShadowOffset 
				shadowColor: aShadowColor
				shadowWidth: aShadowWidth
				offset: anOffset
				thenPaint: aPaintBlock ]
]

{ #category : #'api - layer' }
BlCompositionLayeredPainter >> pushTransform: aMatrix offset: anOffset bounds: aRectangleOrNull compositing: aBlCompositingMode thenPaint: aPaintBlock [

	aBlCompositingMode wantsCompositionLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionTransformationLayer new
					matrix: aMatrix;
					offset: anOffset)
				offset: 0@0
				bounds: aRectangleOrNull
				compositing: aBlCompositingMode
				thenPaint: aPaintBlock ]
		ifFalse: [ self applyTransform: aMatrix offset: anOffset thenPaint: aPaintBlock ]
]
