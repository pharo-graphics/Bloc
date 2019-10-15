Class {
	#name : #BlTextLineEndingUnix,
	#superclass : #BlTextLineEnding,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextLineEndingUnix >> asString [
	^ String lf
]

{ #category : #testing }
BlTextLineEndingUnix >> matches: aCurrentCharacter and: aNextCharacter [
	<return: #Boolean>

	^ aCurrentCharacter = Character lf
]
