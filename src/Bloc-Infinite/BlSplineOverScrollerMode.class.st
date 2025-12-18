"
I'm a `BlScrollFlinger` mode.
"
Class {
	#name : #BlSplineOverScrollerMode,
	#superclass : #Object,
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #updating }
BlSplineOverScrollerMode >> continueOn: aSplineOverScroller [
	"Answer a Boolean that indicates whether scroll animation should continue."
	
	^ self subclassResponsibility
]

{ #category : #updating }
BlSplineOverScrollerMode >> finishOn: aSplineOverScroller [
	"Finish animation and finalize scroller state"

	aSplineOverScroller currentPosition: aSplineOverScroller finalPosition.
	aSplineOverScroller currentVelocity: 0.0.
	aSplineOverScroller isFinished: true.
	aSplineOverScroller updateTime: nil.
]

{ #category : #initialization }
BlSplineOverScrollerMode >> initializeOn: aSplineOverScroller [

	self subclassResponsibility
]

{ #category : #updating }
BlSplineOverScrollerMode >> updateOn: aSplineOverScroller [
	"Update and return true if update has been done and false if animation duration has been reached"

	self subclassResponsibility
]
