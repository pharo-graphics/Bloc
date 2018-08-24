Class {
	#name : #BlGestureSwipeEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureSwipeEvent >> sendTo: anObject [
	anObject gestureSwipeEvent: self
]
