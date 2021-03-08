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

{ #category : #'instance creation' }
BlCompositionPainter class >> forElement: anElement [
	^ anElement wantsSeparateCompositingLayer
		ifTrue: [ BlCompositionLayeredPainter new ]
		ifFalse: [ BlCompositionBufferedPainter new ]
]

{ #category : #painting }
BlCompositionPainter class >> repaintCompositedElement: anElement [
	| anOffsetLayer aPainter |

	anOffsetLayer := anElement hasCompositionLayer
		ifTrue: [ anElement compositionLayer removeAllLayers ]
		ifFalse: [ BlCompositionOffsetLayer new ].

	aPainter := (self forElement: anElement)
		containerLayer: anOffsetLayer;
		bounds: anElement invalidationBounds;
		needsCache: anElement wantsSeparateCompositingLayer.

	anElement fullPaintWithTransformOn: aPainter offset: 0@0.

	aPainter stopRecording.
	anElement wantsSeparateCompositingLayer
		ifTrue: [ anElement compositionLayer: anOffsetLayer ].
	
	^ anOffsetLayer
]

{ #category : #painting }
BlCompositionPainter class >> repaintSpace: aSpace [
	| elementsToRepaint aRootLayer |

	elementsToRepaint := aSpace elementsNeedingPaint collect: [ :eachElement | eachElement -> eachElement compositionDepth ] as: Array.
	elementsToRepaint sort: [ :a :b | a value > b value ].
			
	aSpace telemetry
		timeSync: 'Repaint'
		during: [
			elementsToRepaint
				collect: [ :eachAssociation | eachAssociation key ]
				thenDo: [ :eachElement |
					aSpace telemetry
						timeSync: [ 'Paint ', eachElement class asString ]
						during: [
							(eachElement shouldBePainted and: [ eachElement isAttachedToSceneGraph ])
								ifTrue: [
									eachElement hasCompositionLayer
										ifTrue: [ BlCompositionPainter repaintCompositedElement: eachElement ]
										ifFalse: [ "eachElement markSkippedPaint" ] ] ] ] ].

	aRootLayer := aSpace root hasCompositionLayer
		ifTrue: [ aSpace root compositionLayer ]
		ifFalse: [
			aSpace telemetry
				timeSync: 'Repaint root'
				during: [ BlCompositionPainter repaintCompositedElement: aSpace root ]  ].
	
	aSpace root withAllChildrenBreadthFirstDo: [ :eachChild | eachChild markDoesNotNeedPaint ].
	aRootLayer computeNeedsComposition.
	^ aRootLayer
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

{ #category : #'private - layer' }
BlCompositionPainter >> applyClip: aClipPath offset: anOffset thenPaint: aPaintBlock [
	<argument: #anOffset satisfies: #isSpartaScalarPoint>
	
	self canvasDo: [ :aCanvas |
		aCanvas clip push: aClipPath offset: anOffset ].
	state pushClip: aClipPath offset: anOffset.
	
	aPaintBlock cull: self cull: anOffset.
	
	state pop.
	self canvasDo: [ :aCanvas | aCanvas clip pop ]
]

{ #category : #'private - layer' }
BlCompositionPainter >> applyShadow: aShadowPath shadowOffset: aShadowOffset shadowColor: aShadowColor shadowWidth: aShadowWidth offset: anOffset thenPaint: aPaintBlock [
	self canvas stroke
		path: aShadowPath;
		paint: (self canvas paint boxShadow
			color: aShadowColor;
			offset: aShadowOffset + anOffset;
			radius: aShadowWidth);
		width: aShadowWidth;
		draw.
	aPaintBlock cull: self cull: anOffset
]

{ #category : #'private - layer' }
BlCompositionPainter >> applyTransform: aMatrix offset: anOffset thenPaint: aPaintBlock [
	| thePoppedState |
	
	self canvasDo: [ :aCanvas |
		aCanvas transform
			translateBy: anOffset;
			multiplyBy: aMatrix;
			push ].
	
	state pushTransform: aMatrix offset: anOffset.
	
	aPaintBlock cull: self cull: 0@0.

	thePoppedState := state pop.
	self canvasDo: [ :aCanvas | thePoppedState popOn: aCanvas ]
]

{ #category : #converting }
BlCompositionPainter >> asBufferedPainter [
	^ self subclassResponsibility
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
BlCompositionPainter >> canvas: anObject [
	canvas := anObject
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

{ #category : #accessing }
BlCompositionPainter >> pictureLayer [
	^ pictureLayer
]

{ #category : #accessing }
BlCompositionPainter >> pictureLayer: anObject [
	pictureLayer := anObject
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushChildren: theChildren offset: anOffset compositing: aBlCompositingMode thenPaint: aBlock [
	self subclassResponsibility
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushClip: aClipPath offset: anOffset bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	self subclassResponsibility
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushShadow: aShadowPath shadowOffset: aShadowOffset shadowColor: aShadowColor shadowWidth: aShadowWidth offset: anOffset bounds: aRectangle compositing: aBlCompositingMode thenPaint: aPaintBlock [
	self subclassResponsibility
]

{ #category : #'api - layer' }
BlCompositionPainter >> pushTransform: aMatrix offset: anOffset bounds: aRectangleOrNull compositing: aBlCompositingMode thenPaint: aPaintBlock [
	self subclassResponsibility
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

{ #category : #accessing }
BlCompositionPainter >> state [
	^ state
]

{ #category : #accessing }
BlCompositionPainter >> state: anObject [
	state := anObject
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
