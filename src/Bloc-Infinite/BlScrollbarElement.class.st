"
I'm an abstract scroll bar element.
"
Class {
	#name : #BlScrollbarElement,
	#superclass : #BlElement,
	#instVars : [
		'scrollable',
		'thumb',
		'dragPosition',
		'pullHandler',
		'track',
		'scrollHandler',
		'thumbDragHandler',
		'thumbDragStartHandler'
	],
	#category : #'Bloc-Infinite-Scrollable-Core'
}

{ #category : #'api - scrollbar' }
BlScrollbarElement >> attachTo: aTOBlScrollable [
	"Attach me to a given scrollable element (any element that implements TOBlScrollable trait)"

	scrollable ifNotNil: [ self detachFrom: scrollable ].

	aTOBlScrollable addEventHandler: scrollHandler.
	scrollable := aTOBlScrollable
]

{ #category : #initialization }
BlScrollbarElement >> defaultPullHandler [

	^ self subclassResponsibility
]

{ #category : #initialization }
BlScrollbarElement >> defaultThumbBackground [

	^ Color gray
]

{ #category : #initialization }
BlScrollbarElement >> defaultTrackBackground [

	^ Color black alpha: 0.25
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> detach [
	"Detach me from a scrollable element"

	scrollable ifNil: [ ^ self ].

	self detachFrom: scrollable
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> detachFrom: aTOBlScrollable [
	"Detach me from a given scrollable element (any element that implements TOBlScrollable trait)"

	aTOBlScrollable removeEventHandler: scrollHandler.
	scrollable := nil
]

{ #category : #initialization }
BlScrollbarElement >> initialize [

	super initialize.
	
	self layout: BlFrameLayout new.

	scrollHandler :=
		BlEventHandler
			on: BlElementScrolledEvent
			do: [ :anEvent |
				self isAttachedToScrollable
					ifTrue: [ self updateThumbPosition ] ].
	pullHandler := self defaultPullHandler.
	thumbDragStartHandler :=
		BlEventHandler
			on: BlPullStartEvent
			do: [ :anEvent | dragPosition := anEvent currentTarget position ].
	thumbDragHandler :=
		BlEventHandler
			on: BlPullEvent
			do: [ :anEvent |
				self isAttachedToScrollable ifTrue: [
					 self onDraggedThumbBy: anEvent currentPosition ] ].

	self track: self newDefaultTrack.
	self thumb: self newDefaultThumb
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> isAttachedToScrollable [

	^ scrollable isNotNil
]

{ #category : #initialization }
BlScrollbarElement >> newDefaultThumb [
	"Answer a `BlElement` that represents the default thumb."

	^ self subclassResponsibility
]

{ #category : #initialization }
BlScrollbarElement >> newDefaultTrack [
	"Answer a `BlElement` that represents the default track."
	
	^ self subclassResponsibility
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> onDraggedThumbBy: aPoint [

	self subclassResponsibility
]

{ #category : #'private - thumb' }
BlScrollbarElement >> registerThumb: anElement [

	anElement
		addEventHandler: pullHandler;
		addEventHandler: thumbDragStartHandler;
		addEventHandler: thumbDragHandler
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> scrollableDeltaFromThumbDelta: thumbDelta range: scrollRange length: scrollbarLength [

	| result |
	scrollbarLength isZero ifTrue: [ ^ 0 ].

	(thumbDelta closeTo: 0.0 epsilon: 0.5) ifTrue: [ ^ 0 ].

	result := (thumbDelta * scrollRange / scrollbarLength) asFloat.
	
	(result closeTo: 0.0 epsilon: 0.5) ifTrue: [ ^ 0 ].
	
	^ result
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> thumb [

	^ thumb
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> thumb: anElement [
	
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

	^ track
]

{ #category : #'api - scrollbar' }
BlScrollbarElement >> track: anElement [
	
	track
		ifNotNil: [ :aCurrentTrack | self replaceChild: aCurrentTrack with: anElement as: #track ]
		ifNil: [ self addChild: anElement as: #track ].

	track := anElement
]

{ #category : #'private - thumb' }
BlScrollbarElement >> unregisterThumb: anElement [

	anElement
		removeEventHandler: pullHandler;
		removeEventHandler: thumbDragStartHandler;
		removeEventHandler: thumbDragHandler
]

{ #category : #'private - scrolling' }
BlScrollbarElement >> updateThumbPosition [

	self subclassResponsibility
]
