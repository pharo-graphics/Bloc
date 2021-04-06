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
BlCompositionLayeredPainter >> pushChildren: theChildren offset: anOffsetPoint compositing: aBlCompositingMode thenPaint: aBlock [	
	"anOffsetPoint should satisfies #isSpartaScalarPoint"

	aBlCompositingMode wantsBufferedLayer
		ifTrue: [
			| aNewPainter |
			self stopRecording.
			aNewPainter := self asBufferedPainter.
			theChildren do: [ :eachChild | aBlock cull: eachChild cull: aNewPainter cull: anOffsetPoint ].
			aNewPainter stopRecording ]
		ifFalse: [ theChildren do: [ :eachChild | aBlock cull: eachChild cull: self cull: anOffsetPoint ] ]
]

{ #category : #'api - layer' }
BlCompositionLayeredPainter >> pushClip: aClipPath offset: anOffsetPoint bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	"anOffsetPoint should satisfies #isSpartaScalarPoint"
	
	aBlCompositingMode wantsCompositionLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionClipLayer new
					path: aClipPath;
					offset: anOffsetPoint)
				offset: anOffsetPoint
				bounds: aRectangle
				compositing: false
				thenPaint: aPaintBlock ]
		ifFalse: [ self applyClip: aClipPath offset: anOffsetPoint thenPaint: aPaintBlock ]
]

{ #category : #'private - layer' }
BlCompositionLayeredPainter >> pushLayer: aNewLayer 
	offset: anOffset 
	bounds: aRectangleOrNull 
	compositing: aBlCompositingMode 
	thenPaint: aPaintBlock [
	"anOffsetPoint should satisfies #isSpartaScalarPoint"

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
BlCompositionLayeredPainter >> pushShadow: aShadowPath 
	shadowOffset: aShadowOffset 
	shadowColor: aShadowColor 
	shadowWidth: aShadowWidth 
	offset: anOffsetPoint 
	bounds: aRectangle 
	compositing: aBlCompositingMode 
	thenPaint: aPaintBlock [
	"anOffsetPoint should satisfies #isSpartaScalarPoint"
	
	aBlCompositingMode wantsCompositionLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionShadowLayer new
					offset: anOffsetPoint;
					shadowOffset: aShadowOffset;
					shadowColor: aShadowColor;
					shadowWidth: aShadowWidth;
					shadowPath: aShadowPath)
				offset: anOffsetPoint
				bounds: aRectangle
				compositing: false
				thenPaint: aPaintBlock ]
		ifFalse: [
			self
				applyShadow: aShadowPath
				shadowOffset: aShadowOffset 
				shadowColor: aShadowColor
				shadowWidth: aShadowWidth
				offset: anOffsetPoint
				thenPaint: aPaintBlock ]
]

{ #category : #'api - layer' }
BlCompositionLayeredPainter >> pushTransform: aMatrix offset: anOffsetPoint bounds: aRectangleOrNull compositing: aBlCompositingMode thenPaint: aPaintBlock [
	"anOffsetPoint should satisfies #isSpartaScalarPoint"

	aBlCompositingMode wantsCompositionLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionTransformationLayer new
					matrix: aMatrix;
					offset: anOffsetPoint)
				offset: 0@0
				bounds: aRectangleOrNull
				compositing: aBlCompositingMode
				thenPaint: aPaintBlock ]
		ifFalse: [ self applyTransform: aMatrix offset: anOffsetPoint thenPaint: aPaintBlock ]
]
