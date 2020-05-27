Class {
	#name : #BlCompositionPainter,
	#superclass : #Object,
	#instVars : [
		'containerLayer',
		'pictureLayer',
		'canvas',
		'bounds',
		'matrix'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #'instance creation' }
BlCompositionPainter class >> root: anExtent [
	"Create a root composition painter to be used as the first entrance point of the space painting"
	<return: #BlCompositionPainter>

	^ self new
		bounds: (0@0 extent: anExtent);
		containerLayer: (BlCompositionContainerLayer new)
]

{ #category : #'private - layers' }
BlCompositionPainter >> addLayer: aCompositionLayer [
	containerLayer addLayer: aCompositionLayer
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

{ #category : #initialization }
BlCompositionPainter >> initialize [
	super initialize.
	
	bounds := 0@0 extent: 0@0.
	matrix := SpartaMatrix new
]

{ #category : #testing }
BlCompositionPainter >> isRecording [
	<return: #Boolean>

	^ canvas isNotNil
]

{ #category : #accessing }
BlCompositionPainter >> matrix: aMatrix [
	matrix := aMatrix
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushLayer: aNewLayer offset: anOffset bounds: aRectangleOrNull thenPaint: aPaintBlock [
	<return: #BlCompositionLayer>
	| anAddedLayer aNewPainter aChildLayer |
	
	self stopRecording.
	
	aChildLayer := aNewLayer.
	
	self addLayer: (matrix isIdentity
		ifTrue: [ anAddedLayer := aNewLayer ]
		ifFalse: [
			| aTransformLayer |
			aTransformLayer := BlCompositionLeftOverTransformationLayer new matrix: matrix.
			anAddedLayer := aTransformLayer addLayer: aChildLayer.
			anAddedLayer ]).
	
	aNewPainter := self class new
		containerLayer: aChildLayer;
		bounds: aRectangleOrNull;
		matrix: matrix.
	 aPaintBlock cull: aNewPainter cull: anOffset.

	aNewPainter stopRecording.
	
	^ anAddedLayer
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushOffset: anOffset bounds: aRectangleOrNull from: anElement thenPaint: aPaintBlock [
	<return: #BlCompositionPainter>
	
	^ self
		pushLayer: (BlCompositionOffsetLayer new
			creatorElement: anElement;
			offset: anOffset)
		offset: 0@0
		bounds: aRectangleOrNull
		thenPaint: aPaintBlock
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushOpacity: anAlpha offset: anOffset bounds: aRectangleOrNull from: anElement thenPaint: aPaintBlock [
	<return: #BlCompositionPainter>
	
	^ self
		pushLayer: (BlCompositionOpacityLayer new
			creatorElement: anElement;
			opacity: anAlpha;
			offset: anOffset)
		offset: 0@0
		bounds: aRectangleOrNull
		thenPaint: aPaintBlock
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushTransform: aMatrix offset: anOffset compositing: wantsCompositing bounds: aRectangleOrNull from: anElement thenPaint: aPaintBlock [
	<return: #BlCompositionPainter>

	^ (self shouldCreateNewLayer: wantsCompositing)
		ifTrue: [
			self
				pushLayer: (BlCompositionTransformationLayer new
					creatorElement: anElement;
					matrix: aMatrix;
					offset: anOffset)
				offset: 0@0
				bounds: aRectangleOrNull
				thenPaint: aPaintBlock ]
		ifFalse: [
			| aNextPainter |
			self canvas transform
				by: [ :t | t
					translateBy: anOffset;
					multiplyBy: aMatrix";
					translateBy: anOffset negated" ]
				during: [ aNextPainter := aPaintBlock cull: self cull: 0@0 ].
			aNextPainter ]
]

{ #category : #testing }
BlCompositionPainter >> shouldCreateNewLayer: wantsCompositionLayer [
	^ wantsCompositionLayer
]

{ #category : #'private - canvas' }
BlCompositionPainter >> startRecording [
	pictureLayer := BlCompositionPictureLayer new.
	canvas := SkiaCanvas recording: bounds.
	containerLayer addLayer: pictureLayer
]

{ #category : #'private - canvas' }
BlCompositionPainter >> stopRecording [
	self isRecording
		ifFalse: [ ^ nil ].

	"a leftover transformation matrix"
	matrix := canvas transform current.

	pictureLayer picture: canvas snapshot.
	pictureLayer := nil.
	canvas := nil
]
