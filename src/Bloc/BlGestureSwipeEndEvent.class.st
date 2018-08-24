Class {
	#name : #BlGestureSwipeEndEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureSwipeEndEvent >> sendTo: anObject [
	anObject gestureSwipeEndEvent: self
]
