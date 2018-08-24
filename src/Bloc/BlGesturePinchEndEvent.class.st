"
Is sent right after the end of a pinch gesture
"
Class {
	#name : #BlGesturePinchEndEvent,
	#superclass : #BlGestureBasePinchEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlGesturePinchEndEvent >> sendTo: anObject [
	anObject gesturePinchEndEvent: self
]
