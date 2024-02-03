"
I am an example of a custom bloc event

"
Class {
	#name : 'BlExampleCustomEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'payload'
	],
	#category : 'Bloc-Examples-Event',
	#package : 'Bloc-Examples',
	#tag : 'Event'
}

{ #category : 'accessing' }
BlExampleCustomEvent >> payload [
	^ payload
]

{ #category : 'accessing' }
BlExampleCustomEvent >> payload: anObject [
	payload := anObject
]
