Class {
	#name : #BlGestureRotationBeginEvent,
	#superclass : #BlGestureBaseRotationEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureRotationBeginEvent >> sendTo: anObject [
	anObject gestureRotationBeginEvent: self
]
