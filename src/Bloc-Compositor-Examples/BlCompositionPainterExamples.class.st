"
! Hello 1
"
Class {
	#name : #BlCompositionPainterExamples,
	#superclass : #Object,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #'instance creation' }
BlCompositionPainterExamples >> elementWantingLayerWithTranslationTransform [
	<gtExample>
	|  aContainer aChildA |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 300.
			c vertical exact: 300 ];
		geometry: (BlRectangle cornerRadius: 4);
		border: (BlBorder paint: Color veryLightGray width: 1).

	aChildA := BlExampleElementThatWantsCompositionLayer new
		size: 150@150;
		transformDo: [ :t | t translateBy: 150@75 ];
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).

	aContainer addChild: aChildA.
	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> elementWithTransformationBetweenWantingLayer [
	<gtExample>
	|  aContainer aContent aWrapper aScaled aChildA  aChildB aChildC |
	
	aContainer := BlElement new
		size: 600@400;
		border: (BlBorder paint: Color veryLightGray width: 1).
	
	aContent := BlElement new
		size: 560@360;
		relocate: 20@20;
		background: Color veryVeryLightGray.

	aWrapper := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	
	aScaled := BlElement new size: (560@360) / 2.
	aScaled constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored vertical alignCenter.
		c ignored horizontal alignCenter ].
	aScaled transformDo: [ :t | t scaleBy: 1.5 ].
	aScaled effect: BlGaussianShadowEffect default.
	aScaled background: Color white.
	
	aChildA := BlExampleElementThatWantsCompositionLayer new
		size: 200@40;
		relocate: 20@20;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	aChildB := BlExampleElementThatWantsCompositionLayer new
		size: 200@40;
		relocate: 20@80;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).
		
	aChildC := BlElement new
		size: 200@20;
		relocate: 20@140;
		background: (Color veryVeryLightGray);
		border: (BlBorder paint: Color veryLightGray width: 1).

	aScaled addChildren:  { aChildA . aChildB . aChildC }.
	
	aWrapper addChild: aScaled.
	aContent addChild: aWrapper.
		
	aContent addChild: (BlElement new
		size: 30@30;
		relocate: 55@30;
		background: Color lightGray;
		geometry: (BlCircle new)).
		
	aContent addChild: (BlElement new
		size: 30@30;
		relocate: 475@30;
		background: Color lightGray;
		geometry: (BlCircle new)).
		
	aContainer addChild: aContent.

	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> elementsWantingLayerInsideScalable [
	<gtExample>
	|  aContainer aTitle aFooter aContent aChildA aChildB |
	
	aContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal exact: 300.
			c vertical fitContent ];
		geometry: (BlRectangle cornerRadius: 4);
		border: (BlBorder paint: Color veryLightGray width: 1).
		
	aTitle := BlTextElement new
		text: 'Title' asRopedText;
		constraintsDo: [ :c | c horizontal matchParent ];
		padding: (BlInsets top: 4 left: 6 bottom: 4 right: 6);
		background: Color veryLightGray.
		
	aFooter := BlTextElement new
		text: 'Footer' asRopedText;
		constraintsDo: [ :c | c horizontal matchParent ];
		padding: (BlInsets top: 4 left: 6 bottom: 4 right: 6);
		background: Color veryVeryLightGray.
		
	aContent := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
		
	aChildA := BlExampleElementThatWantsCompositionLayer new
		size: 1000@400;
		background: (Color paleRed);
		margin: (BlInsets all: 30);
		border: (BlBorder paint: Color red width: 1).
		
	aChildB := BlExampleElementThatWantsCompositionLayer new
		size: 500@800;
		background: (Color paleBlue);
		margin: (BlInsets all: 25);
		border: (BlBorder paint: Color blue width: 1).
	
	aContent addChildren: { aChildA . aChildB }.

	aContainer addChild: aTitle.
	aContainer addChild: (aContent asScalableElement height: 400) as: #content.
	aContainer addChild: aFooter.
	
	aContainer forceLayout.
	self assert: aChildB position equals: 25@485.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> overlappingElementWantingLayerInbetweenOtherElements [
	<gtExample>
	|  aContainer aChildA aSubChildA aChildB aSubChildB aChildC aSubChildC |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ];
		border: (BlBorder paint: Color veryLightGray width: 1).
		
	aChildA := BlElement new
		size: 300@300;
		relocate: 0@0;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	aSubChildA := BlExampleElementThatWantsCompositionLayer new
		size: 100@100;
		relocate: 25@25;
		background: (Color blue alpha: 0.2);
		border: (BlBorder paint: Color blue width: 1).
		
	aChildA addChild: aSubChildA.
		
	aChildB := BlExampleElementThatWantsCompositionLayer new
		size: 300@300;
		relocate: 50@50;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).
		
	aSubChildB := BlElement new
		size: 100@100;
		relocate: 25@25;
		background: (Color red alpha: 0.2);
		border: (BlBorder paint: Color red width: 1).
		
	aChildB addChild: aSubChildB.
		
	aChildC := BlElement new
		size: 300@300;
		relocate: 100@100;
		background: (Color paleGreen);
		border: (BlBorder paint: Color green width: 1).
		
	aSubChildC := BlExampleElementThatWantsCompositionLayer new
		size: 100@100;
		relocate: 25@25;
		background: (Color green alpha: 0.2);
		border: (BlBorder paint: Color green width: 1).
		
	aChildC addChild: aSubChildC.

	aContainer addChildren:  { aChildA . aChildB . aChildC }.
	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> overlappingSimpleElementWantingLayerInbetweenOtherElements [
	<gtExample>
	|  aContainer aChildA aChildB aChildC |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ];
		border: (BlBorder paint: Color veryLightGray width: 1).
		
	aChildA := BlElement new
		size: 300@300;
		relocate: 0@0;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	aChildB := BlExampleElementThatWantsCompositionLayer new
		size: 300@300;
		relocate: 50@50;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).
	
	aChildC := BlElement new
		size: 300@300;
		relocate: 100@100;
		background: (Color paleGreen);
		border: (BlBorder paint: Color green width: 1).

	aContainer addChildren:  { aChildA . aChildB . aChildC }.
	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> overlappingSimpleElementWantingLayerInbetweenOtherElementsInParentWithTransformation [
	<gtExample>
	|  aContainer aChildA aChildB aChildC |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ];
		transformDo: [ :t | t topLeftOrigin scaleBy: 1.2 ];
		border: (BlBorder paint: Color veryLightGray width: 1).
		
	aChildA := BlElement new
		size: 300@300;
		relocate: 0@0;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	aChildB := BlExampleElementThatWantsCompositionLayer new
		size: 300@300;
		relocate: 50@50;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).
	
	aChildC := BlElement new
		size: 300@300;
		relocate: 100@100;
		background: (Color paleGreen);
		border: (BlBorder paint: Color green width: 1).

	aContainer addChildren:  { aChildA . aChildB . aChildC }.
	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> overlappingSimpleElementWantingLayerWithTransformInbetweenOtherElements [
	<gtExample>
	|  aContainer aChildA aChildB aChildC |
	
	aContainer := BlExampleElementThatWantsCompositionLayer new
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ];
		border: (BlBorder paint: Color veryLightGray width: 1).
		
	aChildA := BlElement new
		size: 300@300;
		relocate: 0@0;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	aChildB := BlElement new
		size: (300 asPoint / 1.2);
		relocate: 50@50;
		background: (Color paleRed);
		transformDo: [ :t | t topLeftOrigin scaleBy: 1.2 ];
		border: (BlBorder paint: Color red width: 1);
		addChild: (BlExampleElementThatWantsCompositionLayer new
			size: 100@100;
			relocate: 25@25;
			background: (Color red alpha: 0.2);
			border: (BlBorder paint: Color red width: 1)).
	
	aChildC := BlElement new
		size: 300@300;
		relocate: 100@100;
		background: (Color paleGreen);
		border: (BlBorder paint: Color green width: 1).

	aContainer addChildren:  { aChildA . aChildB . aChildC }.
	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> overlappingSimpleElementsWantingLayerInbetweenOtherElementsInParentWithTransformation [
	<gtExample>
	|  aContainer aChildA aChildB aChildC aChildD |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 450.
			c vertical exact: 450 ];
		transformDo: [ :t | t topLeftOrigin scaleBy: 1.2 ];
		border: (BlBorder paint: Color veryLightGray width: 1).
		
	aChildA := BlElement new
		size: 300@300;
		relocate: 0@0;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	aChildB := BlExampleElementThatWantsCompositionLayer new
		size: 300@300;
		relocate: 50@50;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).
		
	aChildC := BlExampleElementThatWantsCompositionLayer new
		size: 300@300;
		relocate: 100@100;
		background: (Color paleYellow);
		border: (BlBorder paint: Color yellow darker width: 1).
	
	aChildD := BlElement new
		size: 300@300;
		relocate: 150@150;
		background: (Color paleGreen);
		border: (BlBorder paint: Color green width: 1).

	aContainer addChildren:  { aChildA . aChildB . aChildC . aChildD }.
	aContainer forceLayout.
	
	^ aContainer
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintElementWantingLayerWithTranslationTransform [
	<gtExample>
	| aContainer aPainter aRootLayer aWhitePictureLayer aLeftoverLayer anOffsetLayer aTransformationLayer aRedPictureLayer |
	
	aContainer := self elementWantingLayerWithTranslationTransform.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer extent.
	
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.
	self assert: aRootLayer layers size equals: 2.
	
	aWhitePictureLayer := aRootLayer layers first.
	
	self assert: (aWhitePictureLayer isKindOf: BlCompositionPictureLayer).
	self assert: aWhitePictureLayer needsCache not.
	self assert: aWhitePictureLayer isSimple.
	self assert: aWhitePictureLayer isWorthCaching not.
	
	aLeftoverLayer := aRootLayer layers second.
	self assert: (aLeftoverLayer isKindOf: BlCompositionLeftoverStateLayer).
	self assert: aLeftoverLayer layers size equals: 1.
	self assert: aLeftoverLayer commands equals: ({
		BlCompositionPainterStateClip new
			offset: 0@0;
			clip: (SpartaRoundedRectangle rectangle: (0@0 extent: 300@300) radii: (SpartaCornerRadii fromArray: #(4 4 4 4)))
	}).
	
	anOffsetLayer := aLeftoverLayer layers first.
	
	self assert: (anOffsetLayer isKindOf: BlCompositionOffsetLayer).
	self assert: anOffsetLayer offset equals: 0.0@0.
	self assert: anOffsetLayer layers size equals: 1.

	aTransformationLayer := anOffsetLayer layers first.
	self assert: (anOffsetLayer isKindOf: BlCompositionOffsetLayer).
	
	aRedPictureLayer := aTransformationLayer layers first.
	
	self assert: (aRedPictureLayer isKindOf: BlCompositionPictureLayer).
	self assert: aRedPictureLayer needsCache.
	self assert: aRedPictureLayer isSimple.
	self assert: aRedPictureLayer isWorthCaching not.

	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintElementWithTransformationBetweenWantingLayer [
	<gtExample>
	| aContainer aPainter aRootLayer |
	
	aContainer := self elementWithTransformationBetweenWantingLayer.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer extent.
	
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.
	
	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintElementsWantingLayerInsideScalable [
	<gtExample>
	| aContainer aPainter aRootLayer |
	
	aContainer := self elementsWantingLayerInsideScalable.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer extent.
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.
	"self assert: aRootLayer layers size equals: 4.
	self assert: (aRootLayer layers first isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers second isKindOf: BlCompositionLeftOverTransformationLayer).
	self assert: (aRootLayer layers third isKindOf: BlCompositionLeftOverTransformationLayer).
	self assert: (aRootLayer layers fourth isKindOf: BlCompositionPictureLayer).

	self assert: (aRootLayer layers second matrix closeTo: (
		SpartaMatrix new
			sx: 0.283;
			sy: 0.283;
			y: 36.623) epsilon: 0.001).
			
	self assert: (aRootLayer layers third matrix closeTo: (
		SpartaMatrix new
			sx: 0.283;
			sy: 0.283;
			y: 36.623) epsilon: 0.001).

	self assert: (aRootLayer layers second layers first offset) equals: (30@30).
	self assert: (aRootLayer layers third layers first offset) equals: (25@485)."
	
	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintOverlappingElementWantingLayerInbetweenOtherElements [
	<gtExample>
	| aContainer aPainter aRootLayer |
	
	aContainer := self overlappingElementWantingLayerInbetweenOtherElements.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer extent.
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.	
	
	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintOverlappingSimpleElementWantingLayerInbetweenOtherElements [
	<gtExample>
	| aContainer aPainter aRootLayer aLeftoverLayer anOffsetLayer aRedPictureLayer |
	
	aContainer := self overlappingSimpleElementWantingLayerInbetweenOtherElements.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer extent.
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.
	
	self assert: aRootLayer layers size equals: 3.
	self assert: (aRootLayer layers first isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers first needsCache not).

	aLeftoverLayer := aRootLayer layers second.
	self assert: (aLeftoverLayer isKindOf: BlCompositionLeftoverStateLayer).
	self assert: aLeftoverLayer commands equals: ({
		BlCompositionPainterStateClip new
			offset: 0@0;
			clip: (0@0 extent: 400@400) }).
	
	anOffsetLayer := aLeftoverLayer layers first.
	self assert: (anOffsetLayer isKindOf: BlCompositionOffsetLayer).
	self assert: anOffsetLayer offset equals: 50@50.
	
	aRedPictureLayer := anOffsetLayer layers first.
	self assert: (aRedPictureLayer isKindOf: BlCompositionPictureLayer).
	self assert: aRedPictureLayer needsCache.
	self assert: aRedPictureLayer isSimple.
	self assert: aRedPictureLayer isWorthCaching not.

	self assert: (aRootLayer layers third isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers third needsCache not).
	
	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintOverlappingSimpleElementWantingLayerInbetweenOtherElementsInParentWithTransformation [
	<gtExample>
	| aContainer aPainter aRootLayer |
	
	aContainer := self overlappingSimpleElementWantingLayerInbetweenOtherElementsInParentWithTransformation.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer transformedBounds extent.
	
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.
	
	"self assert: aRootLayer layers size equals: 3.
	self assert: (aRootLayer layers first isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers first needsCache not).

	self assert: (aRootLayer layers second isKindOf: BlCompositionOffsetLayer).
	self assert: aRootLayer layers second offset equals: 50@50.
	self assert: (aRootLayer layers second layers first isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers second layers first needsCache).

	self assert: (aRootLayer layers third isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers third needsCache not)."
	
	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintOverlappingSimpleElementWantingLayerWithTransformInbetweenOtherElements [
	<gtExample>
	| aContainer aPainter aRootLayer |
	
	aContainer := self overlappingSimpleElementWantingLayerWithTransformInbetweenOtherElements.
	aContainer forceLayout.
	
	aPainter := BlCompositionPainter root: aContainer extent.
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.
	
	"self assert: aRootLayer layers size equals: 3.
	self assert: (aRootLayer layers first isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers first needsCache not).

	self assert: (aRootLayer layers second isKindOf: BlCompositionOffsetLayer).
	self assert: aRootLayer layers second offset equals: 50@50.
	self assert: (aRootLayer layers second layers first isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers second layers first needsCache).

	self assert: (aRootLayer layers third isKindOf: BlCompositionPictureLayer).
	self assert: (aRootLayer layers third needsCache not)."
	
	^ aPainter
]

{ #category : #'examples - painter' }
BlCompositionPainterExamples >> paintOverlappingSimpleElementsWantingLayerInbetweenOtherElementsInParentWithTransformation [
	<gtExample>
	| aContainer aPainter aRootLayer |
	
	aContainer := self overlappingSimpleElementsWantingLayerInbetweenOtherElementsInParentWithTransformation.
	
	aPainter := BlCompositionPainter root: aContainer transformedBounds extent.
	aContainer fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	aRootLayer := aPainter containerLayer.	
	
	^ aPainter
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> showElementsWantingLayerInsideScalable [
	<script: 'self new showElementsWantingLayerInsideScalable'>
	
	^ BlSpace new
		addChild: self elementsWantingLayerInsideScalable;
		show
]

{ #category : #'instance creation' }
BlCompositionPainterExamples >> showOverlappingElementWantingLayerInbetweenOtherElements [
	<script: 'self new showOverlappingElementWantingLayerInbetweenOtherElements'>
	
	^ BlSpace new
		addChild: self overlappingElementWantingLayerInbetweenOtherElements;
		show
]
