Class {
	#name : #BlGestureScrollBeginEvent,
	#superclass : #BlGestureBaseScrollEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureScrollBeginEvent >> sendTo: anObject [
	anObject gestureScrollBeginEvent: self
]
