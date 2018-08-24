Class {
	#name : #BlGestureScrollBeginEvent,
	#superclass : #BlGestureBaseScrollEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureScrollBeginEvent >> sendTo: anObject [
	anObject gestureScrollBeginEvent: self
]
