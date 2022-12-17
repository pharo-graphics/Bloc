Class {
	#name : #BlGestureSwipeBeginEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureSwipeBeginEvent >> sendTo: anObject [
	anObject gestureSwipeBeginEvent: self
]
