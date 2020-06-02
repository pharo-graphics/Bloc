Class {
	#name : #BCompositionExampleElementWithMultipleLayersAndTransformation,
	#superclass : #BlElement,
	#instVars : [
		'blueBox',
		'redBox',
		'grayBox',
		'scaled',
		'container',
		'wrapper',
		'leftCircle',
		'rightCircle'
	],
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> blueBox [
	^ blueBox
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> container [
	^ container
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> grayBox [
	^ grayBox
]

{ #category : #initialization }
BCompositionExampleElementWithMultipleLayersAndTransformation >> initialize [
	super initialize.
	
	self
		size: 600@400;
		border: (BlBorder paint: Color veryLightGray width: 1).
	
	container := BlElement new
		size: 560@360;
		relocate: 20@20;
		background: Color veryVeryLightGray.

	wrapper := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	
	scaled := BlElement new size: (560@360) / 2.
	scaled constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored vertical alignCenter.
		c ignored horizontal alignCenter ].
	scaled transformDo: [ :t | t scaleBy: 1.5 ].
	scaled effect: BlGaussianShadowEffect default.
	scaled background: Color white.
	
	blueBox := BlExampleElementThatWantsCompositionLayer new
		size: 200@40;
		relocate: 20@20;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1).
		
	redBox := BlExampleElementThatWantsCompositionLayer new
		size: 200@40;
		relocate: 20@80;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1).
		
	grayBox := BlElement new
		size: 200@20;
		relocate: 20@140;
		background: (Color veryVeryLightGray);
		border: (BlBorder paint: Color veryLightGray width: 1).

	scaled addChildren:  { blueBox . redBox . grayBox }.
	
	wrapper addChild: scaled.
	container addChild: wrapper.

	container addChild: (leftCircle := BlElement new
		size: 30@30;
		relocate: 55@30;
		background: Color lightGray;
		geometry: BlCircle new).

	container addChild: (rightCircle := BlElement new
		size: 30@30;
		relocate: 475@30;
		background: Color lightGray;
		geometry: BlCircle new).
		
	self addChild: container.
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> leftCircle [
	^ leftCircle
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> redBox [
	^ redBox
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> rightCircle [
	^ rightCircle
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> scaled [
	^ scaled
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> wrapper [
	^ wrapper
]
