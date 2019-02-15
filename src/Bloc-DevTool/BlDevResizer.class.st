"
I visualize the resizing srategy of the element on which I am installed
"
Class {
	#name : #BlDevResizer,
	#superclass : #BlElementEventListener,
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
	anElement addEventFilter: aResizer.
	^ aResizer
]

{ #category : #initialization }
BlDevResizer >> initialize [
	| aColor |
	super initialize.
	
	aColor := Color gray lighter.

	resizer := BlElement new.
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
			background: Color gray;
			border: (BlBorder paint: Color gray width: 3)).
	verticalLine toHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: 3)).
	verticalLine border: (BlBorder builder paint: aColor; width: 3; build).
	verticalLine fromAnchor: (BlElementBottomCenterAnchor element: anchorTopLeft).
	verticalLine toAnchor: (BlElementTopCenterAnchor element: anchorBottomLeft).

	horizontalLine := BlLineElement new.
	horizontalLine fromHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: 3)).
	horizontalLine toHead: (
		BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			background: aColor;
			border: (BlBorder paint: aColor width: 3)).
	horizontalLine border: (BlBorder builder paint: aColor; width: 3; build).
	horizontalLine fromAnchor: (BlElementCenterRightAnchor element: anchorBottomLeftHorizontal).
	horizontalLine toAnchor: (BlElementCenterLeftAnchor element: anchorBottomRight).
	
	verticalText := BlTextElement new text: 'vertical' asRopedText monospace.
	verticalText background: (Color white alpha: 0.5).
	verticalText transformDo: [ :t | t rotateBy: 90 ].
	verticalText constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignLeft.
		c margin: (BlInsets left: -15) ].
	
	horizontalText := BlTextElement new text: 'horizontal' asRopedText monospace.
	horizontalText background: (Color white alpha: 0.5).
	horizontalText constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignCenter.
		c margin: (BlInsets bottom: 15) ].

	resizer addChildren: { anchorTopLeft . anchorBottomLeft . anchorBottomLeftHorizontal . anchorBottomRight . verticalLine . horizontalLine . verticalText . horizontalText }.
]

{ #category : #'api - hooks' }
BlDevResizer >> onInstalledIn: anElement [

	targetElement ifNotNil: [ targetElement removeEventFilter: self ].
	targetElement := anElement.
	targetElement addChild: resizer.
	
	verticalText text: (targetElement constraints vertical resizer asString) asRopedText monospace.
	horizontalText text: (targetElement constraints horizontal resizer asString) asRopedText monospace.
]

{ #category : #'api - hooks' }
BlDevResizer >> onUninstalledIn: anElement [
	resizer removeFromParent
]
