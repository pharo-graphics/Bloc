Class {
	#name : 'BlGestureRotationEndEvent',
	#superclass : 'BlGestureBaseRotationEvent',
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlGestureRotationEndEvent >> sendTo: anObject [
	anObject gestureRotationEndEvent: self
]
