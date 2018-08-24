Class {
	#name : #BlSplineOverScrollerSplineStep,
	#superclass : #BlSplineOverScrollerStep,
	#category : 'Bloc-Utilities - Scrolling Helpers'
}

{ #category : #hooks }
BlSplineOverScrollerSplineStep >> onFinished: aSplineOverScroller [
	<return: #Boolean>
	
	"Duration from start to null velocity"
	aSplineOverScroller duration < aSplineOverScroller splineDuration
		"Normal stop, no need to continue"
		ifFalse: [ ^ false ].
		
	aSplineOverScroller startPosition: aSplineOverScroller finalPosition.
	aSplineOverScroller currentPosition: aSplineOverScroller finalPosition.

	"start velocity should not be fractional, we truncate explicitly to be in sync with an original algorithm"
	aSplineOverScroller startVelocity: (aSplineOverScroller truncated: aSplineOverScroller currentVelocity).

	aSplineOverScroller deceleration: (aSplineOverScroller decelerationFor: aSplineOverScroller startVelocity).
	aSplineOverScroller startTime: aSplineOverScroller startTime + aSplineOverScroller duration.
	
	aSplineOverScroller onEdgeReached.
	
	^ true
]
