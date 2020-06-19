Class {
	#name : #BlScrollableElement,
	#superclass : #BlElement,
	#traits : 'TBlScrollable + TBlAlignable',
	#classTraits : 'TBlScrollable classTrait + TBlAlignable classTrait',
	#instVars : [
		'scrollState',
		'scrollFlinger',
		'scrollPosition',
		'scrollAlignment',
		'horizontalAlignment',
		'verticalAlignment'
	],
	#category : #'Bloc-Utilities - Scrolling'
}

{ #category : #conversion }
BlScrollableElement >> asScrollableElement [
	^ self
]

{ #category : #accessing }
BlScrollableElement >> contentElement [
	self 
		deprecated: 'Use contentElement instead'
		on: 	'8 May 2018' 
		in: 'Pharo-6.0-60540-'.
	^ self contentElement
]

{ #category : #initialization }
BlScrollableElement >> defaultHorizontalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null horizontal
]

{ #category : #initialization }
BlScrollableElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BlScrollableElement >> defaultVerticalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null vertical
]

{ #category : #scrolling }
BlScrollableElement >> flingBy: aVelocityPoint [
	self scrollFlinger flingBy: aVelocityPoint
]

{ #category : #testing }
BlScrollableElement >> hasScrolledElement [
	^ self children isNotEmpty
]

{ #category : #accessing }
BlScrollableElement >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ horizontalAlignment
]

{ #category : #accessing }
BlScrollableElement >> horizontalAlignment: aBlElementAlignment [
	horizontalAlignment := aBlElementAlignment.
	self requestLayout
]

{ #category : #initialization }
BlScrollableElement >> initialize [
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	scrollPosition := 0.0@0.0.
	scrollState := #idle.
	horizontalAlignment := self defaultHorizontalAlignment.
	verticalAlignment := self defaultVerticalAlignment.

	self addEventHandler: BlScrollableElementEventHandler new
]

{ #category : #layout }
BlScrollableElement >> layoutApplyAlignment [
	| aContent |
	
	aContent := self scrolledElement.
	
	(aContent measuredWidth < self width)
		ifTrue: [
			| aHorizontalTranslation |
			aHorizontalTranslation := (self horizontalAlignment translationOf: aContent measuredBounds bounds in: self bounds inLocal bounds) x.
			scrollPosition := scrollPosition + (aHorizontalTranslation @ 0.0) ].
		
	(aContent measuredHeight < self height)
		ifTrue: [
			| aVerticalTranslation |
			aVerticalTranslation := (self verticalAlignment translationOf: aContent measuredBounds bounds in: self bounds inLocal bounds) y.
			scrollPosition := scrollPosition + (0.0 @ aVerticalTranslation) ].
	
	aContent measuredBounds position: scrollPosition
]

{ #category : #layout }
BlScrollableElement >> layoutClampPosition [
	| aCurrentPositionX aContent aMinPositionX aMaxPositionX aNewClampedPositionX aCurrentPositionY aMinPositionY aMaxPositionY aNewClampedPositionY |
	
	aContent := self scrolledElement.
	
	aCurrentPositionX := scrollPosition x.
	aMinPositionX := (self width - aContent measuredWidth) min: 0.0.
	aMaxPositionX := 0.0.
	aNewClampedPositionX := (aCurrentPositionX max: aMinPositionX) min: aMaxPositionX.
	
	aCurrentPositionY := scrollPosition y.
	aMinPositionY := (self height - aContent measuredHeight) min: 0.0.
	aMaxPositionY := 0.0.
	aNewClampedPositionY := (aCurrentPositionY max: aMinPositionY) min: aMaxPositionY.
	scrollPosition := aNewClampedPositionX @ aNewClampedPositionY.

	aContent measuredBounds position: scrollPosition.
]

{ #category : #layout }
BlScrollableElement >> layoutFixGap [
	| aContent aGapX aGapY |
	
	aContent := self scrolledElement.
	
	aGapX := (self width - aContent measuredBounds right) max: 0.0.
	scrollPosition x < 0
		ifTrue: [
			| aNewX |
			aNewX := (scrollPosition x + aGapX) min: 0.0.
			scrollPosition := aNewX @ scrollPosition y ].
	
	aGapY := (self height - aContent measuredBounds bottom) max: 0.0.	
	scrollPosition y < 0
		ifTrue: [
			| aNewY |
			aNewY := (scrollPosition y + aGapY) min: 0.0.
			scrollPosition := scrollPosition x @ aNewY ].

	aContent measuredBounds position: scrollPosition
]

{ #category : #'hooks - children' }
BlScrollableElement >> onChildAdded: anElement [
	super onChildAdded: anElement.
	
	anElement
		constraintsDo: [ :c |
			c frame horizontal alignNone.
			c frame vertical alignNone ]
]

{ #category : #layout }
BlScrollableElement >> onLayout: aBounds [
	self scrollFlinger isIdle
		ifFalse: [ ^ super onLayout: aBounds ].
		
	self hasScrolledElement
		ifFalse: [ ^ self ].
	
	"first we fix a gap"	
	self layoutFixGap.

	"now clamp position"
	self layoutClampPosition.

	"then we allign content if it is smaller than the scrollpane"
	self layoutApplyAlignment.

	super onLayout: aBounds
]

{ #category : #scrolling }
BlScrollableElement >> scrollBy: aPoint [
	"Instant scroll by the given amount of pixels along either axis.
	Return true if a scroll happens."
	<return: #Boolean>
	| aContent dX dY |

	self hasScrolledElement
		ifFalse: [ ^ false ].

	aContent := self scrolledElement.

	dX := aPoint x negated.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition x + dX.
			aMinPosition := (self width - aContent width) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dX := aNewClampedPosition - self scrollPosition x ]
		ifFalse: [ dX := 0.0 ].
	
	self canScrollVertically
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition y + dY.
			aMinPosition := (self height - aContent height) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dY := aNewClampedPosition - self scrollPosition y ]
		ifFalse: [ dY := 0.0 ].
	
	dX isZero
		ifFalse: [self scrollHorizontallyBy: dX  ].

	dY isZero
		ifFalse: [ self scrollVerticallyBy: dY ].
		
	^ ((dX isZero not) or: [ dY isZero not ])
]

{ #category : #'api - scrolling accessing' }
BlScrollableElement >> scrollFlinger [
	<return: #BlScrollFlinger>

	^ scrollFlinger
]

{ #category : #'api - scrolling' }
BlScrollableElement >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>
	| aContent |
	
	aContent := self children first.
	scrollPosition := scrollPosition + (aNumber asFloat @ 0.0).
	aContent relocate: scrollPosition.

	^ aNumber
]

{ #category : #'api - scrolling geometry' }
BlScrollableElement >> scrollMaximum [
	<return: #Point>
	
	^ 0.0@0.0
]

{ #category : #'api - scrolling geometry' }
BlScrollableElement >> scrollMinimum [
	<return: #Point>
	
	^ (self extent - self scrolledElement extent) min: 0.0@0.0
]

{ #category : #'api - scrolling geometry' }
BlScrollableElement >> scrollOvershot [
	<return: #Point>
	
	^ self extent / 2.0
]

{ #category : #'api - scrolling geometry' }
BlScrollableElement >> scrollPosition [
	<return: #Point>
	
	^ scrollPosition
]

{ #category : #'private - scrolling accessing' }
BlScrollableElement >> scrollState [
	"Return the current scrolling state"
	<return: #Symbol>
	
	^ scrollState
]

{ #category : #'private - scrolling accessing' }
BlScrollableElement >> scrollState: aScrollState [
	"Internal! Never set me directly"
	
	scrollState := aScrollState
]

{ #category : #'api - scrolling' }
BlScrollableElement >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>
	| aContent |
	
	aContent := self children first.
	scrollPosition := scrollPosition + (0.0 @ aNumber asFloat).
	aContent relocate: scrollPosition.

	^ aNumber
]

{ #category : #accessing }
BlScrollableElement >> scrolledElement [
	<return: #BlElement>

	^ self children first
]

{ #category : #scrolling }
BlScrollableElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY |
	
	dX := aPoint x.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifFalse: [ dX := 0.0 ].
	
	self canScrollVertically
		ifFalse: [ dY := 0.0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY ]
]

{ #category : #accessing }
BlScrollableElement >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ verticalAlignment
]

{ #category : #accessing }
BlScrollableElement >> verticalAlignment: aBlElementAlignment [
	verticalAlignment := aBlElementAlignment.
	self requestLayout
]
