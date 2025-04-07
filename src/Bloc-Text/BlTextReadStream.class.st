"
I offer API compatible with `ReadStream`.


"
Class {
	#name : #BlTextReadStream,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'iterator'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #'stream - testing' }
BlTextReadStream >> atEnd [
	"Return false if there is a next text item (character) after a current position"
	<return: #Boolean>
	^ self iterator hasNext not
]

{ #category : #accessing }
BlTextReadStream >> contents [

	^ self iterator text asString
]

{ #category : #accessing }
BlTextReadStream >> iterator [
	<return: #BlTextIterator>
	^ iterator
]

{ #category : #accessing }
BlTextReadStream >> iterator: aBlTextIterator [

	iterator := aBlTextIterator
]

{ #category : #'stream - enumeration' }
BlTextReadStream >> next [
	"Return an item (character) at current position and move one to the right"
	
	^ self iterator next
]

{ #category : #'stream - enumeration' }
BlTextReadStream >> next: anAmount [
	"Return a text and move one to the right"
	<return: #BlRope>
	| aPosition aText |
	aPosition := self iterator position.
	aText := self iterator text from: aPosition + 1 to: aPosition + anAmount.
	(self assert: [ aText size = anAmount ] description: [ 'Text does not have a required size' ]).
	self iterator skip: anAmount.
	^ aText
]

{ #category : #accessing }
BlTextReadStream >> nextLine [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>
	^ self iterator nextLine
]

{ #category : #'stream - enumeration' }
BlTextReadStream >> peek [
	"Return an item (character) at current position.
	If the receiver is at the end, answer nil."
	<return: #Character or: #Object>
	^ self iterator hasNext 
		ifTrue: [ self iterator peek ]
		ifFalse: [ nil ]
]

{ #category : #'stream - enumeration' }
BlTextReadStream >> peekBack [

	"Return the element at the previous position, without changing position.  Use indirect messages in case self is a StandardFileStream."

	^ self iterator peer
]

{ #category : #'stream - enumeration' }
BlTextReadStream >> peekFor: anObject [

	"Answer false and do not move over the next element if it is not equal to 
	the argument, anObject, or if the receiver is at the end. Answer true 
	and increment the position for accessing elements, if the next element is 
	equal to anObject."

	| nextObject |
	self atEnd ifTrue: [ ^ false ].
	nextObject := self peek.
	"peek for matching element"
	anObject = nextObject ifTrue: [ ^ self next ].
	^ false
]

{ #category : #'stream - accessing' }
BlTextReadStream >> position [
	"Return current iterator position within a text"
	<return: #Number>
	^ self iterator position
]

{ #category : #'stream - accessing' }
BlTextReadStream >> position: aNumber [
	"Set current iterator position within a text"
	| aDiff |
	aDiff := aNumber - self iterator position.
	self iterator skip: aDiff.
]

{ #category : #'stream - enumeration' }
BlTextReadStream >> skip: anInteger [

	"Set the receiver's position to be the current position+anInteger. A 
	subclass might choose to be more helpful and select the minimum of the 
	receiver's size and position+anInteger, or the maximum of 1 and 
	position+anInteger for the repositioning."
	self iterator skip: anInteger

]

{ #category : #'stream - enumeration' }
BlTextReadStream >> upTo: aCharacter [

	"Answer a subcollection from the current access position to the 
	occurrence (if any, but not inclusive) of anObject in the receiver. If 
	anObject is not in the collection, answer the entire rest of the receiver."

	| start |
	start := self position.
	[ self atEnd or: [ self next = aCharacter ] ] whileFalse: [  ].

	^ BlSubText text: self iterator text from: start to: self position
]
