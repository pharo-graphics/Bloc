"
I am a base class for smooth scrolling. I handle basic tracking of the target element position and provide methods to trigger a programmatic scroll.

"
Class {
	#name : #BlInfiniteSmoothScroller,
	#superclass : #BlSmoothScroller,
	#instVars : [
		'infiniteElement',
		'infiniteLayout',
		'targetPosition',
		'targetElement',
		'action'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Scroller'
}

{ #category : #'children - accessing' }
BlInfiniteSmoothScroller >> childAtPosition: aPosition [
	"@see OBlInfiniteLayout>>#childAtPosition:"
	<return: #BlElement or: nil>

	^ infiniteElement layout childAtPosition: aPosition
]

{ #category : #'children - accessing' }
BlInfiniteSmoothScroller >> childPositionOf: anElement [
	"@see OBlInfiniteElement>>#childLayoutPositionOf:"
	<return: #Number>

	^ infiniteElement childLayoutPositionOf: anElement
]

{ #category : #'children - accessing' }
BlInfiniteSmoothScroller >> childrenCount [
	"@see OBlInfiniteLayout>>#childrenCount"
	<return: #Number>

	^ infiniteElement layout childrenCount
]

{ #category : #initialization }
BlInfiniteSmoothScroller >> defaultAction [
	^ BlInfiniteSmoothScrollerAction new
]

{ #category : #initialization }
BlInfiniteSmoothScroller >> initialize [
	super initialize.
	
	action := self defaultAction
]

{ #category : #accessing }
BlInfiniteSmoothScroller >> layout [
	^ infiniteLayout
]

{ #category : #hooks }
BlInfiniteSmoothScroller >> onChildAttached: anElement [
	"Sent when an item element is attached to this InfiniteElement.
	If attached element corresponds to my target position it becomes my target element"

	(self childPositionOf: anElement) = self targetPosition
		"smooth scroll target element has been attached"
		ifTrue: [ targetElement := anElement ]
]

{ #category : #scrolling }
BlInfiniteSmoothScroller >> onScrollBy: aPoint [
	| anInfiniteElement hadJumpTarget |
	
	anInfiniteElement := infiniteElement.
	(isRunning not or: [ targetPosition = NoPosition or: [ anInfiniteElement isNil ] ])
		ifTrue: [ self stop ].
	
	pendingInitialRun := false.
	targetElement ifNotNil: [ :anElement |
		(self childPositionOf: anElement) = targetPosition
			ifTrue: [ 
				self onTargetFound: anElement action: action.
				action runIfNecessaryOn: anInfiniteElement.
				self stop ] 
			"Passed over target position while smooth scrolling"
			ifFalse: [ targetElement := nil ] ].
	
	isRunning
		ifFalse: [ ^ self ].

	self onSeekTargetStep: aPoint action: action.
	hadJumpTarget := action hasJumpTarget.
	action runIfNecessaryOn: anInfiniteElement.
	hadJumpTarget
		ifTrue: [ 
			isRunning
				ifTrue: [ 
					pendingInitialRun := true.
					infiniteElement postSmoothScroller ]
				ifFalse: [
					"done" 
					self stop ] ]
]

{ #category : #hooks }
BlInfiniteSmoothScroller >> onSeekTargetStep: aDeltaPoint action: aScrollerAction [
	"InfiniteElement will call me each time it scrolls until it can find the target position in the layout.
	SmoothScroller should check aDeltaPoint and if scroll should be changed,
	update the provided aScrollerAction to define the next scroll"

	self subclassResponsibility
]

{ #category : #hooks }
BlInfiniteSmoothScroller >> onStart [
	"Sent when smooth scroll is started. This might be a good time to do setup."
	
	self subclassResponsibility
]

{ #category : #hooks }
BlInfiniteSmoothScroller >> onStop [
	"Sent when smooth scroller is stopped. This is a good place to cleanup your state etc."

	self subclassResponsibility
]

{ #category : #hooks }
BlInfiniteSmoothScroller >> onTargetFound: anElement action: aScrollingAction [
	"Sent when the target position is laid out.
	I am the last message sent SmoothScroller will receive and it should update
	the provided aScrollingAction to define the scroll details towards the target element"
	
	self subclassResponsibility
]

{ #category : #scrolling }
BlInfiniteSmoothScroller >> scrollBy: aPoint [
	| anItemCount |
	
	anItemCount := infiniteElement state itemCount.
	
	"If there are no items in datasource but smooth scroll is running, we need to stop it"
	anItemCount isZero
		ifTrue: [ ^ self stop ].
		
	self targetPosition > anItemCount
		"requested target position is greater that item count, scroll to the last item instead"
		ifTrue: [ self targetPosition: anItemCount ].


	self onScrollBy: aPoint
]

{ #category : #scrolling }
BlInfiniteSmoothScroller >> startOn: anInfiniteElement [
	"Starts a smooth scroll for the given target position (set using targetPosition:).
	In each animation step, InfiniteElement will check for the target element and send either
	#onTargetFound or #onSeekTargetStep until SmoothScroller is stopped.
	Note that if InfiniteElement finds the target element, it will automatically stop the SmoothScroller.
	This does not mean that scroll will stop, it only means it will stop triggering SmoothScroller in each animation step"

	self
		assert: [ anInfiniteElement isNotNil ]
		description: [ 'Can not scroll nil element!' ].

	infiniteElement := anInfiniteElement.
	infiniteLayout := anInfiniteElement layout.
	
	(targetPosition isNil or: [ targetPosition = NoPosition ])
		ifTrue: [ self error: 'Invalid target position: ', targetPosition asString ].
	
	isRunning := true.
	pendingInitialRun := true.
	targetElement := self childAtPosition: targetPosition.
	self onStart.
	infiniteElement postSmoothScroller
]

{ #category : #scrolling }
BlInfiniteSmoothScroller >> stop [

	isRunning
		ifFalse: [ ^ self ].
	
	self onStop.
	targetElement := nil.
	targetPosition :=  NoPosition.
	pendingInitialRun := false.
	isRunning := false.
	
	"trigger a cleanup"
	infiniteLayout onSmoothScrollerStopped: self.
	
	"clear references to avoid any potential leak by a custom smooth scroller"
	infiniteLayout := nil.
	infiniteElement := nil
]

{ #category : #accessing }
BlInfiniteSmoothScroller >> targetPosition [
	^ targetPosition
]

{ #category : #accessing }
BlInfiniteSmoothScroller >> targetPosition: aPosition [
	targetPosition := aPosition
]
