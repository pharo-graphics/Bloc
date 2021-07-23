Class {
	#name : 'BlGestureScrollEndEvent',
	#superclass : 'BlGestureBaseScrollEvent',
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlGestureScrollEndEvent >> sendTo: anObject [
	anObject gestureScrollEndEvent: self
]
