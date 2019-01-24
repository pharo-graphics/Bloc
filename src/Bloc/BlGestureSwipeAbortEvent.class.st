Class {
	#name : #BlGestureSwipeAbortEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureSwipeAbortEvent >> sendTo: anObject [
	anObject gestureSwipeAbortEvent: self
]
