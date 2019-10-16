Class {
	#name : #BlTextLineEndingWindows,
	#superclass : #BlTextLineEnding,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextLineEndingWindows >> asString [
	"I return a string that represents the original piece of text that was replaced with this logical item"
	<return: #String>

	^ String crlf
]

{ #category : #accessing }
BlTextLineEndingWindows >> lookaheadSize [
	"Return how many characters in the original string we should match when replacing with the logical item"
	<return: #Number>
	
	^ 2
]

{ #category : #testing }
BlTextLineEndingWindows >> matches: aCollectionOfCharacters [
	<return: #Boolean>

	^ aCollectionOfCharacters first = Character cr
		and: [ aCollectionOfCharacters second = Character lf ]
]

{ #category : #printing }
BlTextLineEndingWindows >> printOn: aStream [
	"Put a textual description of me on the receiver"

	aStream nextPutAll: '<CRLF>'
]
