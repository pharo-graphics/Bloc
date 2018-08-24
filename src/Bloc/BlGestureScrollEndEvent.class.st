Class {
	#name : #BlGestureScrollEndEvent,
	#superclass : #BlGestureBaseScrollEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureScrollEndEvent >> sendTo: anObject [
	anObject gestureScrollEndEvent: self
]
