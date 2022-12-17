"
I am root class of all higher level gesture events.

The structure is based on the following gesture specification:
https://developer.mozilla.org/en-US/Apps/Fundamentals/User_input_methods/Touch_Gestures_and_Events


"
Class {
	#name : #BlGestureEvent,
	#superclass : #BlUIEvent,
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlGestureEvent >> isGesture [
	^ true
]
