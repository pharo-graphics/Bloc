"
Is sent right before the begin of a pinch gesture
"
Class {
	#name : #BlGesturePinchBeginEvent,
	#superclass : #BlGestureBasePinchEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlGesturePinchBeginEvent >> sendTo: anObject [
	anObject gesturePinchBeginEvent: self
]
