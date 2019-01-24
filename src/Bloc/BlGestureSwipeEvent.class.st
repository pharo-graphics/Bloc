Class {
	#name : #BlGestureSwipeEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureSwipeEvent >> sendTo: anObject [
	anObject gestureSwipeEvent: self
]
