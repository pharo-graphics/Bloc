Class {
	#name : #BlGestureSwipeAbortEvent,
	#superclass : #BlGestureBaseSwipeEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureSwipeAbortEvent >> sendTo: anObject [
	anObject gestureSwipeAbortEvent: self
]
