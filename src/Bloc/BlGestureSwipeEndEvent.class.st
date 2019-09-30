Class {
	#name : #BlGestureSwipeEndEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureSwipeEndEvent >> sendTo: anObject [
	anObject gestureSwipeEndEvent: self
]
