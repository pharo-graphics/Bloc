Class {
	#name : #BlGestureSwipeBeginEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureSwipeBeginEvent >> sendTo: anObject [
	anObject gestureSwipeBeginEvent: self
]
