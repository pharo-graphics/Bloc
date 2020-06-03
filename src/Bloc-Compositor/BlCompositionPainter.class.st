Class {
	#name : #BlCompositionPainter,
	#superclass : #Object,
	#instVars : [
		'containerLayer',
		'pictureLayer',
		'canvas',
		'bounds',
		'state',
		'needsCache'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #painting }
BlCompositionPainter class >> repaintCompositedElement: anElement [
	| anOffsetLayer aPainter |
	
	"NonInteractiveTranscript stdout
		nextPutAll: '[repaint] '; 
		nextPutAll: anElement asString;
		cr."

	anOffsetLayer := anElement compositionLayer
		ifNil: [ BlCompositionOffsetLayer new ]
		ifNotNil: [ :aLayer | aLayer removeAllLayers ].

	aPainter := self new
		containerLayer: anOffsetLayer;
		bounds: anElement invalidationBounds;
		needsCache: anElement wantsCompositionLayer.

	anElement fullPaintWithTransformOn: aPainter offset: 0@0.

	aPainter stopRecording.
	anElement compositionLayer: anOffsetLayer
]

{ #category : #'instance creation' }
BlCompositionPainter class >> root: anExtent [
	"Create a root composition painter to be used as the first entrance point of the space painting"
	<return: #BlCompositionPainter>

	^ self new
		bounds: (0@0 extent: anExtent);
		containerLayer: (BlCompositionContainerLayer new)
]

{ #category : #'api - layer' }
BlCompositionPainter >> addLayer: aCompositionLayer [
	"Add a composition layer wrapping it in a leftover layer if the state is not empty.
	I make sure that a given composition layer is not added to any other layer"
	| anAddedLayer |
	
	aCompositionLayer removeFromParent.
	
	anAddedLayer := state isEmpty
		ifTrue: [ aCompositionLayer ]
		ifFalse: [
			| aStateLayer |
			aStateLayer := BlCompositionLeftoverStateLayer new state: state copy.
			aStateLayer addLayer: aCompositionLayer ].
	
	containerLayer layers
		select: [ :each | each isKindOf: BlCompositionPictureLayer ]
		thenDo: [ :each | each needsCache: false ].

	containerLayer addLayer: anAddedLayer.
	
]

{ #category : #accessing }
BlCompositionPainter >> bounds [
	^ bounds
]

{ #category : #accessing }
BlCompositionPainter >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
BlCompositionPainter >> canvas [
	<return: #SpartaCanvas>

	canvas ifNil: [ self startRecording ].
	^ canvas
]

{ #category : #'private - canvas' }
BlCompositionPainter >> canvasDo: aBlock [
	^ self canvasDo: aBlock ifAbsent: [  ]
]

{ #category : #'private - canvas' }
BlCompositionPainter >> canvasDo: aBlock ifAbsent: anAbsentBlock [
	^ canvas
		ifNil: anAbsentBlock
		ifNotNil: aBlock
]

{ #category : #accessing }
BlCompositionPainter >> containerLayer [
	<return: #BlCompositionContainerLayer>
	
	^ containerLayer
]

{ #category : #accessing }
BlCompositionPainter >> containerLayer: aBlCompositionContainerLayer [
	self
		assert: [ containerLayer isNil ]
		description: [ 'Container layer can not be changed' ].
	
	containerLayer := aBlCompositionContainerLayer
]

{ #category : #'gt-extensions' }
BlCompositionPainter >> gtLayersTreeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Layers';
		priority: 2;
		object: [ self containerLayer ];
		view: #gtTreeFor:
]

{ #category : #'gt-extensions' }
BlCompositionPainter >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 3;
		stencil: [
			| aCanvas aSkiaLayer aCompositor |
			
			aCanvas := SkiaCanvas extent: self bounds extent ceiling asIntegerPoint.
			aSkiaLayer := self containerLayer asSkiaLayer.
			
			aCompositor := SkiaCompositor workers: 1.
			
			aCompositor draw: aSkiaLayer on: aCanvas.
			aCanvas asForm ]
]

{ #category : #'private - canvas' }
BlCompositionPainter >> hasCanvas [
	<return: #Boolean>

	^ canvas isNotNil
]

{ #category : #initialization }
BlCompositionPainter >> initialize [
	super initialize.
	
	bounds := 0@0 extent: 0@0.
	needsCache := false.
	
	state := BlCompositionPainterState new.
]

{ #category : #'private - canvas' }
BlCompositionPainter >> isRecording [
	<return: #Boolean>

	^ self hasCanvas
]

{ #category : #accessing }
BlCompositionPainter >> needsCache [
	^ needsCache
]

{ #category : #accessing }
BlCompositionPainter >> needsCache: anObject [
	needsCache := anObject
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushClip: aClipPath offset: anOffset bounds: aRectangle compositing: wantsCompositingLayer thenPaint: aPaintBlock [
	
	wantsCompositingLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionClipLayer new
					path: aClipPath;
					offset: anOffset)
				offset: anOffset
				bounds: aRectangle
				buffered: false
				thenPaint: aPaintBlock ]
		ifFalse: [
			self canvasDo: [ :aCanvas |
				aCanvas clip push: aClipPath offset: anOffset ].
			state pushClip: aClipPath offset: anOffset.
			
			aPaintBlock cull: self cull: anOffset.
			
			state pop.
			self canvasDo: [ :aCanvas | aCanvas clip pop ] ]
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushLayer: aNewLayer offset: anOffset bounds: aRectangleOrNull buffered: shouldBeBuffered thenPaint: aPaintBlock [
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
BlCompositionPainter >> pushOpacity: anAlpha offset: anOffset bounds: aRectangleOrNull from: anElement thenPaint: aPaintBlock [
	<return: #BlCompositionPainter>
	
	^ self
		pushLayer: (BlCompositionOpacityLayer new
			opacity: anAlpha;
			offset: anOffset)
		offset: 0@0
		bounds: aRectangleOrNull
		buffered: false
		thenPaint: aPaintBlock
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushShadow: aShadowPath shadowOffset: aShadowOffset shadowColor: aShadowColor shadowWidth: aShadowWidth offset: anOffset bounds: aRectangle compositing: wantsCompositingLayer thenPaint: aPaintBlock [
	
	wantsCompositingLayer
		ifTrue: [
			self
				pushLayer: (BlCompositionShadowLayer new
					offset: anOffset;
					shadowOffset: aShadowOffset;
					shadowColor: aShadowColor;
					shadowWidth: aShadowWidth)
				offset: anOffset
				bounds: aRectangle
				buffered: false
				thenPaint: aPaintBlock ]
		ifFalse: [
			self canvas stroke
				path: aShadowPath;
				paint: (self canvas paint boxShadow
					color: aShadowColor;
					offset: aShadowOffset + anOffset;
					radius: aShadowWidth);
				width: aShadowWidth;
				draw.
			aPaintBlock cull: self cull: anOffset ]
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushTransform: aMatrix offset: anOffset bounds: aRectangleOrNull compositing: wantsCompositing buffered: wantsBufferedCompositing thenPaint: aPaintBlock [

	(self shouldCreateNewLayer: wantsCompositing)
		ifTrue: [
			self
				pushLayer: (BlCompositionTransformationLayer new
					matrix: aMatrix;
					offset: anOffset)
				offset: 0@0
				bounds: aRectangleOrNull
				buffered: wantsBufferedCompositing
				thenPaint: aPaintBlock ]
		ifFalse: [
			| aTransform |
			aTransform := self
				canvasDo: [ :aCanvas |
					aCanvas transform
						translateBy: anOffset;
						multiplyBy: aMatrix;
						push ]
				ifAbsent: [ nil ].
			
			state pushTransform: aMatrix offset: anOffset.
			
			aPaintBlock cull: self cull: 0@0.
			
			self canvasDo: [ :aCanvas | aTransform ifNotNil: [ aCanvas transform pop: aTransform ] ].

			state pop ]
]

{ #category : #testing }
BlCompositionPainter >> shouldCreateNewLayer: wantsCompositionLayer [
	^ wantsCompositionLayer
]

{ #category : #'private - canvas' }
BlCompositionPainter >> startRecording [
	pictureLayer := BlCompositionPictureLayer new.
	canvas := SkiaCanvas recording: bounds.
	
	"the new recording canvas should inherit current clip and transformation"
	state applyOnCanvas: canvas.

	containerLayer addLayer: pictureLayer
]

{ #category : #'private - canvas' }
BlCompositionPainter >> stopRecording [
	| aPicture |

	self isRecording
		ifFalse: [ ^ self ].

	aPicture := canvas snapshot.
	
	aPicture isEmpty
		ifTrue: [ pictureLayer removeFromParent ]
		ifFalse: [ pictureLayer needsCache: (needsCache and: [ containerLayer layers size <= 1 ]) ].

	pictureLayer picture: aPicture.
	pictureLayer := nil.
	canvas := nil
]
