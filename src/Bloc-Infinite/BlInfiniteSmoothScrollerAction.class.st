"
I hold information about a smooth scroll request by a SmoothScroller.
"
Class {
	#name : #BlInfiniteSmoothScrollerAction,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'deltaX',
		'deltaY',
		'duration',
		'jumpPosition',
		'interpolator',
		'isChanged',
		'consecutiveUpdates'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : 'Bloc-Infinite-Scroller'
}

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> deltaX [
	^ deltaX
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> deltaX: aNumber [
	isChanged := true.
	deltaX := aNumber
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> deltaY [
	^ deltaY
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> deltaY: aNumber [
	isChanged := true.
	deltaY := aNumber
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> duration [
	<return: #Duration>

	^ duration
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> duration: aDuration [
	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].

	isChanged := true.
	duration := aDuration
]

{ #category : #testing }
BlInfiniteSmoothScrollerAction >> hasDuration [
	"Return true if duration is defined, false otherwise"
	<return: #Boolean>

	^ duration isNotNil
]

{ #category : #testing }
BlInfiniteSmoothScrollerAction >> hasJumpTarget [
	<return: #Boolean>

	^ jumpPosition > 0
]

{ #category : #initialization }
BlInfiniteSmoothScrollerAction >> initialize [
	super initialize.
	
	deltaX := 0.
	deltaY := 0.
	duration := nil. "undefined duration"
	jumpPosition := NoPosition.
	isChanged := false.	
	consecutiveUpdates := 0.
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> interpolator [
	^ interpolator
]

{ #category : #accessing }
BlInfiniteSmoothScrollerAction >> interpolator: anInterpolator [
	isChanged := true.
	interpolator := anInterpolator
]

{ #category : #scrolling }
BlInfiniteSmoothScrollerAction >> jumpTo: aPosition [
	jumpPosition := aPosition
]

{ #category : #scrolling }
BlInfiniteSmoothScrollerAction >> runIfNecessaryOn: anInfiniteElement [

	self hasJumpTarget
		ifTrue: [ 
			| aPosition |
			aPosition := jumpPosition.
			jumpPosition := NoPosition.
			anInfiniteElement jumpToPositionForSmoothScroller: aPosition.
			isChanged := false.
			^ self ].

	isChanged
		ifFalse: [ 
			consecutiveUpdates := 0.
			^ self	 ].
	
	self validate.
	interpolator
		ifNil: [ self hasDuration
			ifTrue: [ anInfiniteElement scrollFlinger
				smoothScrollBy: deltaX @ deltaY
				during: duration ]
			ifFalse: [ anInfiniteElement scrollFlinger
				smoothScrollBy: deltaX @ deltaY  ] ]
		ifNotNil: [ anInfiniteElement scrollFlinger
			smoothScrollBy: deltaX @ deltaY
			during: duration
			with: interpolator ].
	
	consecutiveUpdates := consecutiveUpdates + 1.
	consecutiveUpdates > 10
		"A new action is being set in every animation step. This looks like a bad implementation. Inform developer."
		ifTrue: [ 
			Notification signal: 'Smooth Scroll action is being updated too frequently. Make sure you are not changing it unless necessary' ].
	
	isChanged := false
]

{ #category : #update }
BlInfiniteSmoothScrollerAction >> update: aDistance duration: aDuration interpolator: anInterpolator [
	"Update the action with given parameters"
	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].
		
	deltaX := aDistance x.
	deltaY := aDistance y.
	duration := aDuration.
	interpolator := anInterpolator.
	isChanged := true
]

{ #category : #private }
BlInfiniteSmoothScrollerAction >> validate [
	"I am a class invariant"
	(interpolator isNotNil and: [ duration <= 0 seconds ])
		ifTrue: [ 
			self error: 'If you provide an interpolator you must set a positive duration' ]
		ifFalse: [ 
			duration <= 0 seconds
				ifTrue: [ self error: 'Scroll duration must be a positive number' ] ]
]
