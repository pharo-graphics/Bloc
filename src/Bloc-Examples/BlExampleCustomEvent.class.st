"
I am an example of a custom bloc event
"
Class {
	#name : #BlExampleCustomEvent,
	#superclass : #BlEvent,
	#instVars : [
		'payload'
	],
	#category : 'Bloc-Examples-Event'
}

{ #category : #accessing }
BlExampleCustomEvent >> payload [
	^ payload
]

{ #category : #accessing }
BlExampleCustomEvent >> payload: anObject [
	payload := anObject
]
