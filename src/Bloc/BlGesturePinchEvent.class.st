"
Is sent periodically during the pinch gesture.

"
Class {
	#name : #BlGesturePinchEvent,
	#superclass : #BlGestureBasePinchEvent,
	#instVars : [
		'distance'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlGesturePinchEvent >> distance [
	<return: #Number>

	^ distance
]

{ #category : #accessing }
BlGesturePinchEvent >> distance: aNumber [
	distance := aNumber
]

{ #category : #sending }
BlGesturePinchEvent >> sendTo: anObject [
	anObject gesturePinchEvent: self
]
