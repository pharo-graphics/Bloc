Class {
	#name : #BlDevCrossover,
	#superclass : #BlEventListener,
	#instVars : [
		'crossover',
		'verticalLine',
		'horizontalLine',
		'topRightContainer',
		'mousePositionText',
		'targetElement'
	],
	#category : #'Bloc-DevTool-Tools'
}

{ #category : #'instance creation' }
BlDevCrossover class >> on: anElement [
	| aCrossover |
	
	aCrossover := self new.
	anElement addEventFilter: aCrossover.
	^ aCrossover
]

{ #category : #initialization }
BlDevCrossover >> initialize [
	super initialize.
	
	crossover := BlElement new.
	crossover layout: BlFrameLayout new.
	crossover elevation: (BlRelativeElevation elevation: 1000).
	crossover preventMeAndChildrenMouseEvents.
	crossover constraintsDo: [ :c |
		c ignoreByLayout.
		c infinite holder startIgnoring.
		c horizontal matchParent.
		c vertical matchParent ].

	verticalLine := BlElement new.
	verticalLine background: (Color gray alpha: 0.5).
	verticalLine constraintsDo: [ :c |
		c horizontal exact: 1.
		c vertical matchParent ].

	horizontalLine := BlElement new.
	horizontalLine background: (Color gray alpha: 0.5).
	horizontalLine constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 1 ].

	topRightContainer := BlElement new.
	topRightContainer layout: BlFrameLayout new.
	topRightContainer constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop.
		c horizontal matchParent.
		c vertical matchParent ].

	mousePositionText := BlTextElement new.
	mousePositionText padding: (BlInsets all: 4).
	mousePositionText geometry: (BlRectangle cornerRadius: 4).
	mousePositionText background: (Color white alpha: 0.85).
	mousePositionText text: '' asRopedText.
	mousePositionText constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].

	topRightContainer addChild: mousePositionText.

	crossover addChildren: { verticalLine . horizontalLine . topRightContainer }.
]

{ #category : #'api - hooks' }
BlDevCrossover >> mouseMoveEvent: anEvent [
	verticalLine relocate: anEvent localPosition x @ 0.
	horizontalLine relocate: 0 @ anEvent localPosition y.

	topRightContainer constraintsDo: [ :c |
		c frame horizontal weight: 1 - (anEvent localPosition x / (crossover width max: 1)).
		c frame vertical weight: (anEvent localPosition y / (crossover height max: 1)) ].
		
	mousePositionText text: (anEvent localPosition rounded asString asRopedText monospace fontSize: 11; foreground: Color gray)
]

{ #category : #'api - hooks' }
BlDevCrossover >> onInstalledIn: anElement [

	targetElement ifNotNil: [ targetElement removeEventFilter: self ].
	targetElement := anElement.
	targetElement addChild: crossover
]

{ #category : #'api - hooks' }
BlDevCrossover >> onUninstalledIn: anElement [
	crossover removeFromParent
]
