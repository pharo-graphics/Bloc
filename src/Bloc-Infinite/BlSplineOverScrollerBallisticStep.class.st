"
I'm a ballistic `BlScrollFlinger` step.
"
Class {
	#name : #BlSplineOverScrollerBallisticStep,
	#superclass : #BlSplineOverScrollerStep,
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #hooks }
BlSplineOverScrollerBallisticStep >> onFinished: aSplineOverScroller [
	"Scroller being in ballistic state should spring back, so we continue"

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
