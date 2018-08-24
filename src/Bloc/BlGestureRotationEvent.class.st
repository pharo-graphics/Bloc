Class {
	#name : #BlGestureRotationEvent,
	#superclass : #BlGestureBaseRotationEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureRotationEvent >> sendTo: anObject [
	anObject gestureRotationEvent: self
]
