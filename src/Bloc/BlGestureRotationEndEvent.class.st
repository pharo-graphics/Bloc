Class {
	#name : #BlGestureRotationEndEvent,
	#superclass : #BlGestureBaseRotationEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureRotationEndEvent >> sendTo: anObject [
	anObject gestureRotationEndEvent: self
]
