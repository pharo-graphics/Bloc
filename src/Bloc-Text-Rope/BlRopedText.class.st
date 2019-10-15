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
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRopedText class >> rope: aRope [
	^ self new
		initializeWith: aRope;
		yourself
]

{ #category : #'instance creation' }
BlRopedText class >> string: aString [
	<return: #BlRopedText>

	^ self rope: (BlCollectionRope collection: (BlTextStringNormalizer new process: aString))
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
BlRopedText >> attributes: anAttributesCollection from: aFromIndex to: aToIndex [
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	self rope: (rope attributes: anAttributesCollection from: ((aFromIndex - 1) max: 0) to: aToIndex)
]

{ #category : #'text - attributes' }
BlRopedText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].
		
	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	self rope: (rope clearAttributes: ((aFromIndex - 1) max: 0) to: aToIndex if: aBlock)
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

	^ self class rope: (self rope from: ((aStartIndex - 1) max: 0) to: anEndIndex)
]

{ #category : #'text - modifications' }
BlRopedText >> delete: aFromIndex to: aToIndex [
	
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	rope := rope delete: ((aFromIndex - 1) max: 0) to: aToIndex.
	self notifyDeleted: aFromIndex to: aToIndex
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

	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	self rope
		from: ((aFromIndex - 1) max: 0)
		to: aToIndex
		do: aBlock
]

{ #category : #'text - copying' }
BlRopedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self rope
]

{ #category : #initialization }
BlRopedText >> initialize [
	super initialize
]

{ #category : #initialization }
BlRopedText >> initializeWith: aRope [

	rope := aRope
]

{ #category : #'text - modifications' }
BlRopedText >> insertString: aString at: anIndex [
	rope := rope insertItems: (BlTextStringNormalizer new process: aString) at: anIndex.
	self notifyStringInserted: aString at: anIndex
]

{ #category : #accessing }
BlRopedText >> insertText: aText at: anIndex [
	self
		assert: [ aText isKindOf: BlText ]
		description: [ 'Trying to insert a {1} instead of {2}'
			format: { aText class name . BlText name } ].

	rope := rope insert: aText rope at: anIndex.
	self notifyStringInserted: aText asString at: anIndex
]

{ #category : #'text - testing' }
BlRopedText >> isEmpty [
	<return: #Boolean>

	^ self rope size = 0
]

{ #category : #'text - enumeration' }
BlRopedText >> iterator [
	"Return an iterator pointing to the first text item (character)"
	<return: #BlTextIterator>

	^ BlRopedTextIterator text: self
]

{ #category : #'text - enumeration' }
BlRopedText >> iterator: aFromIndex to: aToIndex [
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BlTextIterator>
	
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end more than by one' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	^ BlRopedTextIterator text: self from: aFromIndex to: aToIndex
]

{ #category : #accessing }
BlRopedText >> rope [
	^ rope
]

{ #category : #accessing }
BlRopedText >> rope: aBrRope [
	rope := aBrRope
]

{ #category : #'text - accessing' }
BlRopedText >> size [
	^ self rope size
]

{ #category : #'text - attributes' }
BlRopedText >> unstyle: aFromIndex to: aToIndex [
	<return: #BlText>
	| anUnstyledRope |

	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: ((aFromIndex - 1) max: 0)
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].

	self rope: anUnstyledRope
]
