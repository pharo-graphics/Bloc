"
Is sent every frame if there are pressed keys.
Users can get access to pressed keys from provided event buffer 
"
Class {
	#name : #BlKeysPressedEvent,
	#superclass : #BlKeyboardEvent,
	#instVars : [
		'buffer'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlKeysPressedEvent >> buffer [
	^ buffer
]

{ #category : #accessing }
BlKeysPressedEvent >> buffer: aBlKeyboardBuffer [
	buffer := aBlKeyboardBuffer
]

{ #category : #sending }
BlKeysPressedEvent >> sendTo: anObject [
	anObject keysPressedEvent: self
]
