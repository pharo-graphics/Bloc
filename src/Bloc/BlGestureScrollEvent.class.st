Class {
	#name : #BlGestureScrollEvent,
	#superclass : #BlGestureBaseScrollEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureScrollEvent >> sendTo: anObject [
	anObject gestureScrollEvent: self
]
