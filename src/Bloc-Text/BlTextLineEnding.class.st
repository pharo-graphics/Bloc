"
I represent a line ending for a specific platform
"
Class {
	#name : #BlTextLineEnding,
	#superclass : #BlTextLogicalItem,
	#category : #'Bloc-Text-Text'
}

{ #category : #comparing }
BlTextLineEnding >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	anObject == self asString first
		ifTrue: [ ^ true ].

	^ self class = anObject class
]

{ #category : #converting }
BlTextLineEnding >> asCharacter [
	"Return the closest character representation of this item.
	It is needed of a user wants to get an item to character mapping between BlText and String (of the same size)"
	<return: #Character>

	^ Character lf
]

{ #category : #comparing }
BlTextLineEnding >> hash [
	^ self class hash
]

{ #category : #testing }
BlTextLineEnding >> isLineBreak [
	^ true
]

{ #category : #testing }
BlTextLineEnding >> isSeparator [
	^ true
]

{ #category : #converting }
BlTextLineEnding >> textRunOn: aStream [
	"When rendering text we should convert logical items to something that will actually appear
	on the screen and something that can be measured. For example a Tab can not be measured not
	rendered and therefore should be converted to a sequence of spaces"

	aStream nextPut: Character cr
]
