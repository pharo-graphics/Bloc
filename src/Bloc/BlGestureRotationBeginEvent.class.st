Class {
	#name : #BlGestureRotationBeginEvent,
	#superclass : #BlGestureBaseRotationEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGestureRotationBeginEvent >> sendTo: anObject [
	anObject gestureRotationBeginEvent: self
]
