"
I'm an horizontal scroll bar element.
"
Class {
	#name : #BlHorizontalScrollbarElement,
	#superclass : #BlScrollbarElement,
	#category : #'Bloc-Infinite-Scrollable-Core'
}

{ #category : #initialization }
BlHorizontalScrollbarElement >> defaultPullHandler [

	^ BlPullHandler new
		  disallowOutOfBounds;
		  beHorizontal;
		  yourself
]

{ #category : #initialization }
BlHorizontalScrollbarElement >> initialize [

	super initialize.

	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]
]

{ #category : #initialization }
BlHorizontalScrollbarElement >> newDefaultThumb [

	^ BlElement new
		  background: self defaultThumbBackground;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c frame horizontal weight: 0.25 ];
		  height: 8;
		  yourself
]

{ #category : #initialization }
BlHorizontalScrollbarElement >> newDefaultTrack [

	^ BlElement new
		  background: self defaultTrackBackground;
		  constraintsDo: [ :c |
			  c vertical exact: 1.
			  c horizontal matchParent.
			  c frame vertical alignCenter ];
		  yourself
]

{ #category : #'private - scrolling' }
BlHorizontalScrollbarElement >> onDraggedThumbBy: aPoint [

	| scrollableDelta |
	scrollableDelta := self
		scrollableDeltaFromThumbDelta: aPoint x - dragPosition x
		range: scrollable computeHorizontalScrollRange
		length: self width.

	scrollableDelta isZero ifTrue: [ ^ self ].

	scrollable scrollBy: scrollableDelta negated @ 0.
	
	dragPosition := aPoint
]

{ #category : #'private - scrolling' }
BlHorizontalScrollbarElement >> updateThumbPosition [

	| contentLength scrollOffset scrollExtent thumbWeight thumbLeft |
	contentLength := scrollable computeHorizontalScrollRange.
	contentLength isZero ifTrue: [ ^ self ].
	scrollOffset := scrollable computeHorizontalScrollOffset.
	scrollExtent := scrollable computeHorizontalScrollExtent.
	
	self visibility: (contentLength <= scrollExtent 
		ifTrue: [ BlVisibility hidden ]
		ifFalse: [ BlVisibility visible ]).
	
	thumbWeight := (scrollExtent / contentLength) asFloat.
	thumbLeft := (scrollOffset / contentLength) asFloat.
	
	thumb constraintsDo: [ :c | 
		c horizontal matchParent.
		c frame horizontal
			alignLeftAt: thumbLeft;
			weight: thumbWeight ]
]
