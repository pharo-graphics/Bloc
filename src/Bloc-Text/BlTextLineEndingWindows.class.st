Class {
	#name : #BlTextLineEndingWindows,
	#superclass : #BlTextLineEnding,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextLineEndingWindows >> asString [
	^ String crlf
]

{ #category : #testing }
BlTextLineEndingWindows >> matches: aCurrentCharacter and: aNextCharacter [
	<return: #Boolean>

	^ aCurrentCharacter = Character cr
		and: [ aNextCharacter = Character lf ]
]
