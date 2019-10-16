Class {
	#name : #BlTextLineEndingUnix,
	#superclass : #BlTextLineEnding,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextLineEndingUnix >> asString [
	"I return a string that represents the original piece of text that was replaced with this logical item"
	<return: #String>

	^ String lf
]

{ #category : #accessing }
BlTextLineEndingUnix >> lookaheadSize [
	"Return how many characters in the original string we should match when replacing with the logical item"
	<return: #Number>
	
	^ 1
]

{ #category : #testing }
BlTextLineEndingUnix >> matches: aCollectionOfCharacters [
	<return: #Boolean>
	
	^ aCollectionOfCharacters first = Character lf
]

{ #category : #testing }
BlTextLineEndingUnix >> matches: aCurrentCharacter and: aNextCharacter [
	<return: #Boolean>

	^ aCurrentCharacter = Character lf
]

{ #category : #printing }
BlTextLineEndingUnix >> printOn: aStream [
	"Put a textual description of me on the receiver"

	aStream nextPutAll: '<LF>'
]
