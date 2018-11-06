"
I am a concrete implementation of a text model backed up by a persistent rope data structure.

See BrText for more information.
See BrRope to learn more about rope
"
Class {
	#name : #BlRopedText,
	#superclass : #BlText,
	#instVars : [
		'rope'
	],
	#category : 'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRopedText class >> rope: aRope [
	^ self new
		initializeWith: aRope;
		yourself
]

{ #category : #'instance creation' }
BlRopedText class >> string: aString [
	^ self rope: (BlCollectionRope collection: aString)
]

{ #category : #'text - converting' }
BlRopedText >> asRopedText [
	^ self
]

{ #category : #'text - converting' }
BlRopedText >> asString [
	^ rope asString
]

{ #category : #'text - accessing' }
BlRopedText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>

	^ self rope at: anIndex
]

{ #category : #'text - attributes' }
BlRopedText >> attributes: anAttributesCollection [

	self rope: (rope attributes: anAttributesCollection)
]

{ #category : #'text - attributes' }
BlRopedText >> attributes: anAttributesCollection from: aStart to: anEnd [
		
	self rope: (rope attributes: anAttributesCollection from: aStart to: anEnd)
]

{ #category : #'text - attributes' }
BlRopedText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
		
	self rope: (rope clearAttributes: aFromIndex to: aToIndex if: aBlock)
]

{ #category : #'text - copying' }
BlRopedText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.

	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	aStartIndex > anEndIndex
		ifTrue: [ ^ self empty ].

	^ self class rope: (self rope from: aStartIndex to: anEndIndex)
]

{ #category : #'text - modifications' }
BlRopedText >> delete: aStart to: anEnd [
	rope := rope delete: aStart to: anEnd.
	self notifyDeleted: aStart to: anEnd
]

{ #category : #'text - enumeration' }
BlRopedText >> do: aBlock [
	self rope do: aBlock
]

{ #category : #'text - accessing' }
BlRopedText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self class string: ''
]

{ #category : #'text - enumeration' }
BlRopedText >> from: aFromIndex to: aToIndex do: aBlock [
	self rope from: aFromIndex to: aToIndex do: aBlock
]

{ #category : #'text - copying' }
BlRopedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self rope
]

{ #category : #initialization }
BlRopedText >> initialize [
	super initialize.
	
	locked := false
]

{ #category : #initialization }
BlRopedText >> initializeWith: aRope [

	rope := aRope
]

{ #category : #'text - modifications' }
BlRopedText >> insertString: aString at: anIndex [
	rope := rope insertItems: aString at: anIndex.
	self notifyStringInserted: aString at: anIndex
]

{ #category : #accessing }
BlRopedText >> insertText: aString at: anIndex [
	rope := rope insertItems: aString at: anIndex.
	self notifyStringInserted: aString at: anIndex
]

{ #category : #'text - testing' }
BlRopedText >> isEmpty [
	^ self rope isEmpty
]

{ #category : #'text - lock' }
BlRopedText >> isLocked [
	^ locked
]

{ #category : #'text - enumeration' }
BlRopedText >> iterator [
	"Return an iterator pointing to the first text item (character)"
	<return: #BlTextIterator>

	^ BlRopedTextIterator text: self
]

{ #category : #'text - enumeration' }
BlRopedText >> iterator: aStartIndex to: anEndIndex [
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BlTextIterator>

	^ BlRopedTextIterator text: self from: aStartIndex to: anEndIndex
]

{ #category : #'text - lock' }
BlRopedText >> lock [
	locked := true
]

{ #category : #accessing }
BlRopedText >> rope [
	^ rope
]

{ #category : #accessing }
BlRopedText >> rope: aBrRope [

	locked ifTrue: [ BlTextLockedError signal: 'Can not modify locked text!' ].

	rope := aBrRope
]

{ #category : #'text - accessing' }
BlRopedText >> size [
	^ self rope size
]

{ #category : #'text - lock' }
BlRopedText >> unlock [
	locked := false
]

{ #category : #'text - attributes' }
BlRopedText >> unstyle: aFromIndex to: aToIndex [
	<return: #BlText>
	| anUnstyledRope |

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: aFromIndex
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].

	self rope: anUnstyledRope
]
