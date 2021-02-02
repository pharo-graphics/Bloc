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
		labeled: 'container';
		size: 560@360;
		relocate: 20@20;
		background: Color veryVeryLightGray.

	wrapper := BlElement new
		labeled: 'wrapper';
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: (Color black alpha: 1) width: 1);
		when: BlClickEvent do: [
			scaled hasParent
				ifTrue: [ scaled removeFromParent ]
				ifFalse: [ wrapper addChild: scaled ] ].
	
	scaled := BlElement new
		labeled: 'scaled / shadow';
		size: (560@360) / 2;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored vertical alignCenter.
			c ignored horizontal alignCenter ];
		transformDo: [ :t | t scaleBy: 1.5 ];
		effect: BlGaussianShadowEffect default;
		background: Color white.
	
	blueBox := BlExampleElementThatWantsCompositionLayer new
		size: 200@40;
		relocate: 20@20;
		background: (Color paleBlue);
		border: (BlBorder paint: Color blue width: 1);
		when: BlMouseDownEvent do: [ :anEvent | anEvent currentTarget background: Color random lighter lighter ].
		
	redBox := self newRedBox.

	grayBox := BlElement new
		size: 200@20;
		relocate: 20@140;
		background: (Color veryVeryLightGray);
		border: (BlBorder paint: Color veryLightGray width: 1);
		when: BlMouseDownEvent do: [ :anEvent | anEvent currentTarget background: Color random lighter lighter ].

	scaled addChildren:  { blueBox . redBox . grayBox }.
	
	wrapper addChild: scaled.
	container addChild: wrapper.

	container addChild: (leftCircle := self newLeftCircle).

	container addChild: (rightCircle := BlElement new
		size: 30@30;
		relocate: 475@30;
		background: Color lightGray;
		geometry: BlCircle new;
		when: BlMouseDownEvent do: [ :anEvent | anEvent currentTarget background: Color random lighter lighter ]).
		
	self addChild: container.
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> leftCircle [
	^ leftCircle
]

{ #category : #initialization }
BCompositionExampleElementWithMultipleLayersAndTransformation >> newLeftCircle [
	^ BlElement new
		size: 30@30;
		relocate: 55@30;
		background: Color lightGray;
		geometry: BlCircle new;
		when: BlMouseDownEvent do: [ :anEvent | anEvent currentTarget background: Color random lighter lighter ];
		when: BlMouseUpEvent do: [ :anEvent | anEvent currentTarget parent replaceChild: anEvent currentTarget with: self newLeftCircle ]
]

{ #category : #initialization }
BCompositionExampleElementWithMultipleLayersAndTransformation >> newRedBox [
	^ BlExampleElementThatWantsCompositionLayer new
		size: 200@40;
		relocate: 20@80;
		background: (Color paleRed);
		border: (BlBorder paint: Color red width: 1);
		when: BlMouseDownEvent do: [ :anEvent | anEvent currentTarget background: Color random lighter lighter ];
		when: BlMouseUpEvent do: [ :anEvent | anEvent currentTarget parent replaceChild: anEvent currentTarget with: self newRedBox ]
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
BCompositionExampleElementWithMultipleLayersAndTransformation >> shadow [
	"an element with the shadow and transformation"

	^ scaled
]

{ #category : #accessing }
BCompositionExampleElementWithMultipleLayersAndTransformation >> wrapper [
	^ wrapper
]
