"
I'm the fling `BlScrollFlinger` mode.
"
Class {
	#name : #BlSplineOverScrollerFlingMode,
	#superclass : #BlSplineOverScrollerMode,
	#instVars : [
		'velocity',
		'startPosition',
		'minPosition',
		'maxPosition',
		'overshotDistance'
	],
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #updating }
BlSplineOverScrollerFlingMode >> continueOn: aSplineOverScroller [

	| aResult |
	aResult := aSplineOverScroller currentStep onFinished: aSplineOverScroller.
	aResult ifFalse: [ ^ false ].

	^ true
]

{ #category : #initialization }
BlSplineOverScrollerFlingMode >> initializeOn: aSplineOverScroller [

	| aTotalDistance |
	aSplineOverScroller overshotDistance: self overshotDistance.
	aSplineOverScroller isFinished: false.

	aSplineOverScroller startPosition: self startPosition.
	aSplineOverScroller startVelocity: self velocity.
	
	
	aSplineOverScroller updateTime
		ifNil: [ aSplineOverScroller startTime: aSplineOverScroller time now ]
		ifNotNil: [ aSplineOverScroller startTime: aSplineOverScroller updateTime ].
	
	"aSplineOverScroller startTime = aSplineOverScroller updateTime
		ifFalse: [ aSplineOverScroller startTime: aSplineOverScroller time now ]."
		
	"self velocity isZero ifFalse: [
		{
		#start -> aSplineOverScroller startTime.
		#update -> aSplineOverScroller updateTime.
		#now -> aSplineOverScroller time now } asDictionary logCr ]."

	aSplineOverScroller currentPosition: self startPosition.
	aSplineOverScroller currentVelocity: self velocity.
	
	aSplineOverScroller duration: 0 milliSeconds.
	aSplineOverScroller splineDuration: 0 milliSeconds.
	
	(self startPosition > self maxPosition or: [ self startPosition < self minPosition ])
		ifTrue: [
			^ aSplineOverScroller
				startAfterEdgeFor: self velocity
				start: self startPosition
				min: self minPosition
				max: self maxPosition ].

	aSplineOverScroller switchToSpline.
	aTotalDistance := 0.
	
	"almost zero"
	(self velocity abs < 0.001)
		ifFalse: [ 
			| aSplineDuration |
			
			aSplineDuration := aSplineOverScroller splineFlingDurationFor: self velocity.

			aSplineOverScroller duration: aSplineDuration.
			aSplineOverScroller splineDuration: aSplineDuration.
			
			aTotalDistance := aSplineOverScroller splineFlingDistanceFor: self velocity ].
	
	"spline distance must be a truncated integer to prevent fractional movements"
	aSplineOverScroller splineDistance: (aSplineOverScroller truncated: (aTotalDistance * self velocity sign)).
	aSplineOverScroller finalPosition: self startPosition + aSplineOverScroller splineDistance.

	"Clamp to a valid final position"
	aSplineOverScroller finalPosition < self minPosition
		ifTrue: [ 
			aSplineOverScroller duration: (aSplineOverScroller
				adjustDuration: aSplineOverScroller duration
				start: self startPosition final: self minPosition
				previousFinal: aSplineOverScroller finalPosition).
			aSplineOverScroller finalPosition: self minPosition ].
	
	aSplineOverScroller finalPosition > self maxPosition
		ifTrue: [ 
			aSplineOverScroller duration: (aSplineOverScroller
				adjustDuration: aSplineOverScroller duration
				start: self startPosition final: self maxPosition
				previousFinal: aSplineOverScroller finalPosition).
			aSplineOverScroller finalPosition: self maxPosition ]
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> maxPosition [

	^ maxPosition
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> maxPosition: anObject [

	maxPosition := anObject
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> minPosition [

	^ minPosition
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> minPosition: anObject [

	minPosition := anObject
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> overshotDistance [

	^ overshotDistance
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> overshotDistance: anObject [

	overshotDistance := anObject
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> startPosition [

	^ startPosition
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> startPosition: anObject [

	startPosition := anObject
]

{ #category : #updating }
BlSplineOverScrollerFlingMode >> updateOn: aSplineOverScroller [
	"Update the current position and velocity for current time.
	Returns true if update has been done and false if animation duration has been reached."

	| aCurrentTime aDeltaTime aDistance |

	aCurrentTime := aSplineOverScroller time now.

	aDeltaTime := aCurrentTime - aSplineOverScroller startTime.

	"Skip work but report that we're still going if we have a nonzero duration."
	aDeltaTime isZero ifTrue: [ ^ aSplineOverScroller duration isZero not ].

	aDeltaTime > aSplineOverScroller duration ifTrue: [ ^ false ].

	aDistance := 0.0.
	
	aSplineOverScroller currentStep = BlSplineOverScrollerStep spline
		ifTrue: [ aDistance := aSplineOverScroller updateSpline: aDeltaTime ].
	aSplineOverScroller currentStep = BlSplineOverScrollerStep ballistic
		ifTrue: [ aDistance := aSplineOverScroller updateBallistic: aDeltaTime ].
	aSplineOverScroller currentStep = BlSplineOverScrollerStep cubic
		ifTrue: [ aDistance := aSplineOverScroller updateCubic: aDeltaTime ].
	
	"Distance must be rounded and position converted to integer to prevent fractional locations"
	aSplineOverScroller currentPosition:
		(aSplineOverScroller startPosition + (aSplineOverScroller rounded: aDistance)).

	^ true
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> velocity [

	^ velocity
]

{ #category : #accessing }
BlSplineOverScrollerFlingMode >> velocity: anObject [

	velocity := anObject
]
