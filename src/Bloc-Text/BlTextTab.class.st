Class {
	#name : #BlTextTab,
	#superclass : #BlTextLogicalItem,
	#category : #'Bloc-Text-Text'
}

{ #category : #comparing }
BlTextTab >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	anObject = Character tab
		ifTrue: [ ^ true ].

	^ self class = anObject class
]

{ #category : #converting }
BlTextTab >> asCharacter [
	"Return the closest character representation of this item.
	It is needed of a user wants to get an item to character mapping between BlText and String (of the same size)"
	<return: #Character>

	^ Character tab
]

{ #category : #converting }
BlTextTab >> asString [
	<return: #String>

	^ String tab
]

{ #category : #comparing }
BlTextTab >> hash [
	^ self class hash
]

{ #category : #testing }
BlTextTab >> isSeparator [
	^ true
]

{ #category : #testing }
BlTextTab >> isTab [
	^ true
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
	aStream nextPut: Character space.
	aStream nextPut: Character space.
	aStream nextPut: Character space.
	aStream nextPut: Character space
]
