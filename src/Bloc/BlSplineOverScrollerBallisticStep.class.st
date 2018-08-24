Class {
	#name : #BlSplineOverScrollerBallisticStep,
	#superclass : #BlSplineOverScrollerStep,
	#category : 'Bloc-Utilities - Scrolling Helpers'
}

{ #category : #hooks }
BlSplineOverScrollerBallisticStep >> onFinished: aSplineOverScroller [
	"Scroller being in ballistic state should spring back, so we continue"
	<return: #Boolean>
	| aNewStartTime |
	
	aNewStartTime := aSplineOverScroller startTime + aSplineOverScroller duration.
	aSplineOverScroller startTime: aNewStartTime.

	"yes, we need to invert positions to spring back"
	aSplineOverScroller
		startSpringbackFor: 0
		start: aSplineOverScroller finalPosition
		end: aSplineOverScroller startPosition.

	^ true
]
