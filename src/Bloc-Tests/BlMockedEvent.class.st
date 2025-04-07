"
I am an example of a custom bloc event

"
Class {
	#name : #BlMockedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'payload'
	],
	#category : #'Bloc-Tests-Events'
}

{ #category : #accessing }
BlMockedEvent >> payload [

	^ payload
]

{ #category : #accessing }
BlMockedEvent >> payload: anObject [

	payload := anObject
]
