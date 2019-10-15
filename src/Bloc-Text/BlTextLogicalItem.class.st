"
One logical item can be seen as one *special* character in a sense that it occupies exactly one place inside of the text.
"
Class {
	#name : #BlTextLogicalItem,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #cleanup }
BlTextLogicalItem class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlTextLogicalItem class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #converting }
BlTextLogicalItem >> asCharacter [
	"Return the closest character representation of this item.
	It is needed of a user wants to get an item to character mapping between BlText and String (of the same size)"
	<return: #Character>

	^ self subclassResponsibility
]

{ #category : #converting }
BlTextLogicalItem >> asString [
	"I should return a string that represents the original piece of text that was replaced with this logical item"
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #testing }
BlTextLogicalItem >> isDigit [
	^ false
]

{ #category : #testing }
BlTextLogicalItem >> isLetter [
	^ false
]

{ #category : #testing }
BlTextLogicalItem >> isLineBreak [
	^ false
]

{ #category : #testing }
BlTextLogicalItem >> isSeparator [
	^ false
]

{ #category : #testing }
BlTextLogicalItem >> isTab [
	^ false
]

{ #category : #accessing }
BlTextLogicalItem >> lookaheadSize [
	"Return how many characters in the original string we should match when replacing with the logical item"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlTextLogicalItem >> matches: aCollectionOfCharacters [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #printing }
BlTextLogicalItem >> printOn: aStream [
	"Append to the argument aStream a sequence of characters that is a textual description of me,
	for example '<TAB>' or '<CR>'"

	self subclassResponsibility
]

{ #category : #printing }
BlTextLogicalItem >> storeOn: aStream [
	"Append to the argument aStream a sequence of characters that is an 
	expression whose evaluation creates an object similar to the receiver."
	
	aStream nextPutAll: self asString
]

{ #category : #converting }
BlTextLogicalItem >> textRunOn: aStream [
	"When rendering text we should convert logical items to something that will actually appear
	on the screen and something that can be measured. For example a Tab can not be measured not
	rendered and therefore should be converted to a sequence of spaces"

	self subclassResponsibility
]
