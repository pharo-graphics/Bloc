Class {
	#name : #BlTextTab,
	#superclass : #BlTextLogicalItem,
	#category : #'Bloc-Text-Text'
}

{ #category : #converting }
BlTextTab >> asString [
	<return: #String>

	^ String tab
]

{ #category : #accessing }
BlTextTab >> lookaheadSize [
	"Return how many characters in the original string we should match when replacing with the logical item"
	<return: #Number>
	
	^ 1
]

{ #category : #testing }
BlTextTab >> matches: aCollectionOfCharacters [
	<return: #Boolean>
	
	^ aCollectionOfCharacters first = Character tab
]

{ #category : #printing }
BlTextTab >> printOn: aStream [
	"Append to the argument aStream a sequence of characters that is a textual description of me"

	aStream nextPutAll: '<TAB>'
]

{ #category : #converting }
BlTextTab >> textRunOn: aStream [
	"When rendering text we should convert logical items to something that will actually appear
	on the screen and something that can be measured. For example a Tab can not be measured not
	rendered and therefore should be converted to a sequence of spaces"

	"For now hardcode the amount of spaces that one tab represents"
	aStream nextPut: Character cr.
	aStream nextPut: Character cr.
	aStream nextPut: Character cr.
	aStream nextPut: Character cr
]
