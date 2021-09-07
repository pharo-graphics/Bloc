"
I offer API compatible with {{gtClass:ReadStream}}.


"
Class {
	#name : 'BlTextReadStream',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'iterator'
	],
	#category : 'Bloc-Text-Text'
}

{ #category : 'stream - testing' }
BlTextReadStream >> atEnd [
	"Return false if there is a next text item (character) after a current position"
	<return: #Boolean>
	^ self iterator hasNext not
]

{ #category : 'accessing' }
BlTextReadStream >> iterator [
	<return: #BlTextIterator>
	^ iterator
]

{ #category : 'accessing' }
BlTextReadStream >> iterator: aBlTextIterator [
	self 
		assert: [ aBlTextIterator isNotNil ] 
		description: [ 'Text iterator must be non-nil' ].
	iterator := aBlTextIterator
]

{ #category : 'stream - enumeration' }
BlTextReadStream >> next [
	"Return an item (character) at current position and move one to the right"
	<return: #Character or: #Object>
	^ self iterator next
]

{ #category : 'stream - enumeration' }
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

{ #category : 'accessing' }
BlTextReadStream >> nextLine [
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>
	^ self iterator nextLine
]

{ #category : 'stream - enumeration' }
BlTextReadStream >> peek [
	"Return an item (character) at current position.
	If the receiver is at the end, answer nil."
	<return: #Character or: #Object>
	^ self iterator hasNext 
		ifTrue: [ self iterator peek ]
		ifFalse: [ nil ]
]

{ #category : 'stream - accessing' }
BlTextReadStream >> position [
	"Return current iterator position within a text"
	<return: #Number>
	^ self iterator position
]

{ #category : 'stream - accessing' }
BlTextReadStream >> position: aNumber [
	"Set current iterator position within a text"
	| aDiff |
	aDiff := aNumber - self iterator position.
	self iterator skip: aDiff.
]
