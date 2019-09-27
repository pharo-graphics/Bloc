Class {
	#name : #BlGestureBaseRotationEvent,
	#superclass : #BlGestureEvent,
	#instVars : [
		'angle'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlGestureBaseRotationEvent >> angle [
	^ angle
]

{ #category : #accessing }
BlGestureBaseRotationEvent >> angle: anObject [
	angle := anObject
]
