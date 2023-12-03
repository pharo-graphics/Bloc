Class {
	#name : #BlSplineOverScrollerMode,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #updating }
BlSplineOverScrollerMode >> continueOn: aSplineOverScroller [
	<return: #Boolean>
	
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
	<return: #Boolean>

	self subclassResponsibility
]
