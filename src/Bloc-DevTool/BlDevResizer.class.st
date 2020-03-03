"
I visualize the resizing srategy of the element on which I am installed

[[[
element := BlElement new
	layout: BlFrameLayout new;
	constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal exact: 300 ];
	look: BrShadowLook new;
	background: Color white;
	margin: (BlInsets all: 30);
	padding: (BlInsets all: 40);
	addChild: (BlElement new
		constraintsDo: [ :c | c frame horizontal alignCenter ];
		background: (Color gray alpha: 0.2);
		size: 100@250).
		
BlDevResizer on: element.

element
]]]
"
Class {
	#name : #BlDevResizer,
	#superclass : #BlEventListener,
	#instVars : [
		'targetElement',
		'resizer',
		'verticalLine',
		'horizontalLine',
		'anchorTopLeft',
		'anchorBottomLeft',
		'anchorBottomRight',
		'verticalText',
		'horizontalText',
		'anchorBottomLeftHorizontal'
	],
	#category : #'Bloc-DevTool-Tools'
}

{ #category : #'instance creation' }
BlDevResizer class >> on: anElement [
	| aResizer |
	
	aResizer := self new.
	aResizer beInside.
	self removeFrom: anElement.
	anElement addEventFilter: aResizer.
	^ aResizer
]

{ #category : #'instance creation' }
BlDevResizer class >> outsideOn: anElement [
	| aResizer |
	
	aResizer := self new.
	aResizer beOutside.
	self removeFrom: anElement.
	anElement addEventFilter: aResizer.
	^ aResizer
]

{ #category : #'instance creation' }
BlDevResizer class >> removeFrom: anElement [
	anElement removeEventFiltersSuchThat: [ :each | each isKindOf: self ]
]

{ #category : #strategies }
BlDevResizer >> beInside [
	verticalText margin: (BlInsets left: 15).
	horizontalText margin: (BlInsets bottom: 15)
]

{ #category : #strategies }
BlDevResizer >> beOutside [
	verticalText margin: (BlInsets left: -15).
	horizontalText margin: (BlInsets bottom: -15)
]

{ #category : #initialization }
BlDevResizer >> initialize [
	| aColor aWidth |
	super initialize.
	
	aColor := Color gray lighter lighter.
	aWidth := 2.

	resizer := BlElement new.
	resizer clipChildren: false.
	resizer background: (Color white alpha: 0.4).
	resizer layout: BlFrameLayout new.
	resizer elevation: (BlRelativeElevation elevation: 1000).
	resizer preventMeAndChildrenMouseEvents.
	resizer constraintsDo: [ :c |
		c ignoreByLayout.
		c infinite holder startIgnoring.
		c horizontal matchParent.
		c vertical matchParent ].

	anchorTopLeft := BlElement new.
	anchorTopLeft constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignLeft.
		c horizontal exact: 15.
		c vertical exact: 2 ].
	
	anchorBottomLeft := BlElement new.
	anchorBottomLeft constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignLeft.
		c horizontal exact: 15.
		c vertical exact: 8 ].
	
	anchorBottomLeftHorizontal := BlElement new.
	anchorBottomLeftHorizontal constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignLeft.
		c horizontal exact: 8.
		c vertical exact: 15 ].
	
	anchorBottomRight := BlElement new.
	anchorBottomRight constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignRight.
		c horizontal exact: 2.
		c vertical exact: 15 ].

	verticalLine := BlLineElement new.
	verticalLine fromHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: aWidth)).
	verticalLine toHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: aWidth)).
	verticalLine border: (BlBorder builder paint: aColor; width: aWidth; build).
	verticalLine fromAnchor: (BlElementBottomCenterAnchor element: anchorTopLeft).
	verticalLine toAnchor: (BlElementTopCenterAnchor element: anchorBottomLeft).

	horizontalLine := BlLineElement new.
	horizontalLine fromHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: aWidth)).
	horizontalLine toHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: aWidth)).
	horizontalLine border: (BlBorder builder paint: aColor; width: aWidth; build).
	horizontalLine fromAnchor: (BlElementCenterRightAnchor element: anchorBottomLeftHorizontal).
	horizontalLine toAnchor: (BlElementCenterLeftAnchor element: anchorBottomRight).

	verticalText := BlTextElement new text: 'vertical' asRopedText monospace vertical.
	verticalText tightMeasurement.
	verticalText clipChildren: false.
	verticalText background: (Color white alpha: 0.5).
	verticalText constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignLeft. ].
	
	horizontalText := BlTextElement new text: 'horizontal' asRopedText monospace.
	horizontalText clipChildren: false.
	horizontalText background: (Color white alpha: 0.5).
	horizontalText constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignCenter. ].

	self beOutside.

	resizer addChildren: { anchorTopLeft . anchorBottomLeft . anchorBottomLeftHorizontal . anchorBottomRight . verticalLine . horizontalLine . verticalText . horizontalText }.
]

{ #category : #'api - hooks' }
BlDevResizer >> onInstalledIn: anElement [

	targetElement ifNotNil: [ targetElement removeEventFilter: self ].
	targetElement := anElement.
	targetElement addChild: resizer.
	
	verticalText text: (targetElement constraints vertical resizer asString) asRopedText monospace vertical.
	horizontalText text: (targetElement constraints horizontal resizer asString) asRopedText monospace.
]

{ #category : #'api - hooks' }
BlDevResizer >> onUninstalledIn: anElement [
	resizer removeFromParent
]
