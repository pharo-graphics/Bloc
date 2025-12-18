"
I'm the scroll `BlScrollFlinger` mode.
"
Class {
	#name : #BlSplineOverScrollerScrollMode,
	#superclass : #BlSplineOverScrollerMode,
	#instVars : [
		'interpolator',
		'startPosition',
		'distance',
		'duration'
	],
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #updating }
BlSplineOverScrollerScrollMode >> continueOn: aSplineOverScroller [
	"Simple scroll mode does not need to continue, animation can be finished"

	^ false
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> distance [

	^ distance
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> distance: anObject [

	distance := anObject
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> duration [

	^ duration
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> duration: aDuration [

	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].

	duration := aDuration
]

{ #category : #initialization }
BlSplineOverScrollerScrollMode >> initializeOn: aSplineOverScroller [

	aSplineOverScroller isFinished: false.
	aSplineOverScroller startPosition: self startPosition.
	aSplineOverScroller currentPosition: self startPosition.
	aSplineOverScroller finalPosition: self startPosition + self distance.
	
	aSplineOverScroller updateTime
		ifNil: [ aSplineOverScroller startTime: aSplineOverScroller time now ]
		ifNotNil: [ aSplineOverScroller startTime: aSplineOverScroller updateTime ].

	aSplineOverScroller duration: self duration.
	
	aSplineOverScroller deceleration: 0.0.
	aSplineOverScroller startVelocity: 0
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> interpolator [

	^ interpolator
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> interpolator: anObject [

	interpolator := anObject
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> startPosition [

	^ startPosition
]

{ #category : #accessing }
BlSplineOverScrollerScrollMode >> startPosition: anObject [

	startPosition := anObject
]

{ #category : #updating }
BlSplineOverScrollerScrollMode >> updateOn: aSplineOverScroller [

	| aCurrentTime anElapsedTime aDuration |

	aCurrentTime := aSplineOverScroller time now.

	anElapsedTime := aCurrentTime - aSplineOverScroller startTime.
	aDuration := aSplineOverScroller duration.

	anElapsedTime < aDuration
		ifTrue: [ 
			| anInterpolatedTime anInterpolatedTranslation aNewPosition |
			
			anInterpolatedTime := self interpolator interpolate: (anElapsedTime / aDuration) asFloat.			
			anInterpolatedTranslation :=
				anInterpolatedTime * (aSplineOverScroller finalPosition - aSplineOverScroller startPosition).
			aNewPosition := aSplineOverScroller startPosition + anInterpolatedTranslation.
			
			aSplineOverScroller currentPosition: aNewPosition ].
		
	^ anElapsedTime < aDuration
]
