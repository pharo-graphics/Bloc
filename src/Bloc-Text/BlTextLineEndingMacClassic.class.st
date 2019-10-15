"
On the Mac Classic (Mac systems using any system prior to Mac OS X), line-endings are terminated with a single carriage return (\r or CR).
Mac OS X uses the UNIX convention.
"
Class {
	#name : #BlTextLineEndingMacClassic,
	#superclass : #BlTextLineEnding,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextLineEndingMacClassic >> asString [
	"I return a string that represents the original piece of text that was replaced with this logical item"
	<return: #String>

	^ String cr
]

{ #category : #accessing }
BlTextLineEndingMacClassic >> lookaheadSize [
	"Return how many characters in the original string we should match when replacing with the logical item"
	<return: #Number>
	
	^ 1
]

{ #category : #testing }
BlTextLineEndingMacClassic >> matches: aCollectionOfCharacters [
	<return: #Boolean>
	
	^ aCollectionOfCharacters first = Character cr
]

{ #category : #printing }
BlTextLineEndingMacClassic >> printOn: aStream [
	"Put a textual description of me on the receiver"

	aStream nextPutAll: '<CR>'
]
