Class {
	#name : #BlScrollableElement,
	#superclass : #BlElement,
	#traits : 'TBlScrollable + TBlAlignable',
	#classTraits : 'TBlScrollable classTrait + TBlAlignable classTrait',
	#instVars : [
		'scrollState',
		'scrollFlinger',
		'scrollPosition',
		'horizontalAlignment',
		'verticalAlignment'
	],
	#category : #'Bloc-Infinite-Scrollable-Core'
}

{ #category : #conversion }
BlScrollableElement >> asScrollableElement [
	^ self
]

{ #category : #'api - scrolling thumb' }
BlScrollableElement >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ self width
]

{ #category : #'api - scrolling thumb' }
BlScrollableElement >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ scrollPosition x negated
]

{ #category : #'api - scrolling thumb' }
BlScrollableElement >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ self scrolledElement width + self scrolledElement margin width + self padding width
]

{ #category : #'api - scrolling thumb' }
BlScrollableElement >> computeVerticalScrollExtent [
	"Compute the vertical extent of the vertical scrollbar's thumb within the vertical range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollRange and #computeVerticalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	
	^ self height
]

{ #category : #'api - scrolling thumb' }
BlScrollableElement >> computeVerticalScrollOffset [
	"Compute the vertical offset of the vertical scrollbar's thumb within the vertical range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"

	^ scrollPosition y negated
]

{ #category : #'api - scrolling thumb' }
BlScrollableElement >> computeVerticalScrollRange [
	"Compute the vertical range that the vertical scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"

	^ self scrolledElement height + self scrolledElement margin height + self padding height
]

{ #category : #initialization }
BlScrollableElement >> defaultEventHandler [

	^ BlScrollableElementEventHandler new
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
BlScrollableElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ BlScrollFlinger
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

	scrollFlinger := self defaultScrollFlinger on: self.
	scrollPosition := 0.0@0.0.
	scrollState := #idle.
	horizontalAlignment := self defaultHorizontalAlignment.
	verticalAlignment := self defaultVerticalAlignment.
	self addEventHandler: self defaultEventHandler
]

{ #category : #layout }
BlScrollableElement >> layoutApplyAlignment: aLayoutNode [
	| aContentNode |
	
	aContentNode := aLayoutNode children first.
	
	(aContentNode width < self width)
		ifTrue: [
			| aHorizontalTranslation |
			aHorizontalTranslation := (self horizontalAlignment translationOf: aContentNode bounds in: self bounds inLocal bounds) x.
			scrollPosition := scrollPosition + (aHorizontalTranslation @ 0.0) ].
		
	(aContentNode height < self height)
		ifTrue: [
			| aVerticalTranslation |
			aVerticalTranslation := (self verticalAlignment translationOf: aContentNode bounds in: self bounds inLocal bounds) y.
			scrollPosition := scrollPosition + (0.0 @ aVerticalTranslation) ].
	
	aContentNode position: scrollPosition
]

{ #category : #layout }
BlScrollableElement >> layoutClampPosition: aLayoutNode [
	| aCurrentPositionX aContentNode aMinPositionX aMaxPositionX aNewClampedPositionX aCurrentPositionY aMinPositionY aMaxPositionY aNewClampedPositionY |
	
	aContentNode := aLayoutNode children first.
	
	aCurrentPositionX := scrollPosition x.
	aMinPositionX := (self width - aContentNode width) min: 0.0.
	aMaxPositionX := 0.0.
	aNewClampedPositionX := (aCurrentPositionX max: aMinPositionX) min: aMaxPositionX.
	
	aCurrentPositionY := scrollPosition y.
	aMinPositionY := (self height - aContentNode height) min: 0.0.
	aMaxPositionY := 0.0.
	aNewClampedPositionY := (aCurrentPositionY max: aMinPositionY) min: aMaxPositionY.
	scrollPosition := aNewClampedPositionX @ aNewClampedPositionY.
	
	aContentNode position: scrollPosition
]

{ #category : #layout }
BlScrollableElement >> layoutFixGap: aLayoutNode [
	| aContentNode aGapX aGapY |
	
	aContentNode := aLayoutNode children first.
	
	aGapX := (self width - aContentNode right) max: 0.0.
	scrollPosition x < 0
		ifTrue: [
			| aNewX |
			aNewX := (scrollPosition x + aGapX) min: 0.0.
			scrollPosition := aNewX @ scrollPosition y ].
	
	aGapY := (self height - aContentNode bottom) max: 0.0.	
	scrollPosition y < 0
		ifTrue: [
			| aNewY |
			aNewY := (scrollPosition y + aGapY) min: 0.0.
			scrollPosition := scrollPosition x @ aNewY ].

	aContentNode position: scrollPosition
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
BlScrollableElement >> onLayout: aBounds context: aBlElementBoundsUpdater [

	| aPreviousScrollPosition aLayoutNode scrollGap |
	self scrollFlinger isIdle ifFalse: [
		^ super onLayout: aBounds context: aBlElementBoundsUpdater ].

	self hasScrolledElement ifFalse: [ ^ self ].

	aLayoutNode := self userData at: #layoutNode ifAbsent: [ ^ self ].

	aPreviousScrollPosition := scrollPosition.

	"first we fix a gap"
	self layoutFixGap: aLayoutNode.

	"now clamp position"
	self layoutClampPosition: aLayoutNode.

	"then we allign content if it is smaller than the scrollpane"
	self layoutApplyAlignment: aLayoutNode.

	super onLayout: aBounds context: aBlElementBoundsUpdater.

	scrollGap := scrollPosition - aPreviousScrollPosition.
	aBlElementBoundsUpdater hasChanges ifTrue: [
		self dispatchEvent: BlBoundsHasChangedDuringScrollingEvent new ].
	self dispatchOnScrolled: scrollGap
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

	dX := aPoint x.
	dY := aPoint y negated.
	
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
	aContent position: scrollPosition.

	self dispatchOnScrolled: aNumber @ 0.

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

	| aContent |
	aContent := self children first.
	scrollPosition := scrollPosition + (0.0 @ aNumber asFloat).
	aContent position: scrollPosition.

	self dispatchOnScrolled: 0 @ aNumber.

	^ aNumber
]

{ #category : #accessing }
BlScrollableElement >> scrolledElement [
	"Return the scrolled BlElement."

	^ self children first
]

{ #category : #accessing }
BlScrollableElement >> scrolledElementDo: aBlock [
	"Evaluate a given block with the scrolled element if any"

	self children ifNotEmpty: [ :theChildren | aBlock value: theChildren first ]
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
