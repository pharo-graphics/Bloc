Class {
	#name : #BlGestureRotationEvent,
	#superclass : #BlGestureBaseRotationEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGestureRotationEvent >> sendTo: anObject [
	anObject gestureRotationEvent: self
]
