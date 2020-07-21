Class {
	#name : #BlScrollbarElement,
	#superclass : #BlElement,
	#instVars : [
		'scrollable',
		'thumb',
		'minimumSize',
		'dragPosition',
		'pullHandler',
		'pullStartHandler',
		'pullEndHandler',
		'pullDragHandler',
		'track',
		'scrollHandler'
	],
	#category : #'Bloc-Utilities - Scrolling'
}

{ #category : #'api - scrollbar' }
BlScrollbarElement >> attachTo: aTBlScrollable [
	"Attach me to a given scrollable element (any element that implements TBlScrollable trait)"

	scrollable
		ifNotNil: [ self detachFrom: scrollable ].

	aTBlScrollable addEventHandler: scrollHandler.
	scrollable := aTBlScrollable
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> computeScrollDeltaFrom: anOldDragPosition to: aNewDragPosition offset: aScrollOffset range: aScrollRange length: aScrollbarLength [
	| aPercentage scrollingBy |

	aScrollbarLength isZero
		ifTrue: [ ^ 0 ].

	(aNewDragPosition closeTo: anOldDragPosition epsilon: 0.5)
		ifTrue: [ ^ 0 ].

	aPercentage := ((aNewDragPosition - anOldDragPosition) / aScrollbarLength) asFloat.
	scrollingBy := aPercentage * aScrollRange.
	
	(scrollingBy closeTo: 0 epsilon: 0.5)
		ifTrue: [ ^ 0 ].
	
	^ scrollingBy
]

{ #category : #initialization }
BlScrollbarElement >> defaultPullHandler [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlScrollbarElement >> defaultThumb [
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlScrollbarElement >> defaultTrack [
	<return: #BlElement>
	
	^ self subclassResponsibility
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> detach [
	"Detach me from a scrollable element"

	scrollable
		ifNil: [ ^ self ].
		
	self detachFrom: scrollable
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> detachFrom: aTBlScrollable [
	"Detach me from a given scrollable element (any element that implements TBlScrollable trait)"

	aTBlScrollable removeEventHandler: scrollHandler.
	scrollable := nil
]

{ #category : #initialization }
BlScrollbarElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.

	minimumSize := 0.05.

	scrollHandler := BlEventHandler
		on: BlElementScrolledEvent
		do: [ :anEvent | self onScrolled: anEvent currentTarget ].
	pullHandler := self defaultPullHandler.
	pullStartHandler := BlEventHandler on: BlPullStartEvent do: [ dragPosition := nil ].
	pullDragHandler := BlEventHandler on: BlPullEvent do: [ :anEvent | self onDragged: anEvent ].
	pullEndHandler := BlEventHandler on: BlPullEndEvent do: [ dragPosition := nil ].

	self track: self defaultTrack.
	self thumb: self defaultThumb
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> isAttachedToScrollable [
	^ scrollable isNotNil
]

{ #category : #'hooks - scrolling' }
BlScrollbarElement >> onDragged: anEvent [
	self isAttachedToScrollable
		ifFalse: [ ^ self ].

	dragPosition := dragPosition
		ifNil: [ anEvent currentTarget position ].

	self scrollTo: anEvent newPosition
]

{ #category : #'hooks - scrolling' }
BlScrollbarElement >> onScrolled: aScrollable [
	self isAttachedToScrollable
		ifFalse: [ ^ self ].

	self updateScrollPosition
]

{ #category : #'private - thumb' }
BlScrollbarElement >> registerThumb: anElement [
	anElement addEventHandler: pullHandler.
	anElement addEventHandler: pullStartHandler.
	anElement addEventHandler: pullDragHandler.
	anElement addEventHandler: pullEndHandler
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> scrollTo: aPoint [
	self subclassResponsibility
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> thumb [
	<return: #BlElement>

	^ thumb
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> thumb: anElement [
	<return: #BlElement>
	
	thumb
		ifNotNil: [ :aCurrentThumb |
			self unregisterThumb: aCurrentThumb.
			self replaceChild: aCurrentThumb with: anElement as: #thumb ]
		ifNil: [ self addChild: anElement as: #thumb ].
	
	thumb := anElement.
	self registerThumb: thumb
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> track [
	<return: #BlElement>

	^ track
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> track: anElement [
	<return: #BlElement>
	
	track
		ifNotNil: [ :aCurrentTrack | self replaceChild: aCurrentTrack with: anElement as: #track ]
		ifNil: [ self addChild: anElement as: #track ].

	track := anElement
]

{ #category : #'private - thumb' }
BlScrollbarElement >> unregisterThumb: anElement [
	anElement removeEventHandler: pullHandler.
	anElement removeEventHandler: pullStartHandler.
	anElement removeEventHandler: pullDragHandler.
	anElement removeEventHandler: pullEndHandler
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> updateScrollPosition [
	self subclassResponsibility
]
