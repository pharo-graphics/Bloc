"
I represent a part of original text from ===start=== to ===end===.
All subtexts of a BrText share the same text instance.
I modify the underlying text when I am modified.

Essentially, I offer a scope that can be used  by upper layers, such as editors, to make it easier to manipulate a logical piece of text, such as a line, or a paragraph.
"
Class {
	#name : #BlSubText,
	#superclass : #BlText,
	#instVars : [
		'text',
		'start',
		'end'
	],
	#category : 'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlSubText class >> empty: aBrText [
	"Returns a sub-text that is backed up by an empty text"
	<return: #BlSubText>
	
	self
		assert: [ aBrText isEmpty ]
		description: [ 'Underlying text must be empty in order to create empty sub-text' ].
		
	^ self
		text: aBrText
		from: 0
		to: 0
]

{ #category : #'instance creation' }
BlSubText class >> text: aBrText [
	self
		assert: [ (aBrText isKindOf: self) not ]
		description: [ 'Can not create sub text of a subtext' ].

	^ self new
		text: aBrText from: 1 to: aBrText size;
		yourself
]

{ #category : #'instance creation' }
BlSubText class >> text: aBrText from: aStartIndex to: anEndIndex [
	self
		assert: [ (aBrText isKindOf: self) not ]
		description: [ 'Can not create sub text of a subtext' ].

	^ self new
		text: aBrText from: aStartIndex to: anEndIndex;
		yourself
]

{ #category : #comparing }
BlSubText >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject start = self start
		and: [ anotherObject end = self end
			and: [ anotherObject text = self text ] ]
]

{ #category : #asserting }
BlSubText >> assertInvariant [
	self assertStart: start end: end
]

{ #category : #asserting }
BlSubText >> assertStart: aStartIndex end: anEndIndex [
	self
		assert: [ aStartIndex isInteger and: [ anEndIndex isInteger ] ]
		description: [ 'Only integers are alowed as start and end indices' ].
	self
		assert: [ text isNotNil ]
		description: [ 'Text must not be nil' ].
	self
		assert: [ aStartIndex between: 0 and: text size ]
		description: [ 'Sub-text start index is out of bounds!' ].
	self
		assert: [ anEndIndex between: 0 and: text size ]
		description: [ 'Sub-text end index is out of bounds!' ].
	self
		assert: [ text isNotEmpty or: [ aStartIndex isZero and: [ anEndIndex isZero ] ] ]
		description: [ 'If text is empty, start and end indices must be Zero!' ].
	self
		assert: [ aStartIndex isZero not or: [ anEndIndex isZero ] ]
		description: [ 'If start index is zero then end index must also be zero' ].
	self
		assert: [ anEndIndex isZero not or: [ aStartIndex isZero ] ]
		description: [ 'If end index is zero then start index must also be zero' ]
]

{ #category : #'text - accessing' }
BlSubText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>
	
	^ self text at: anIndex + start - 1
]

{ #category : #'text - attributes' }
BlSubText >> attributes: anAttributesCollection [
	"Apply given attributes on the whole text"

	self text attributes: anAttributesCollection from: start to: end
]

{ #category : #'text - attributes' }
BlSubText >> attributes: anAttributesCollection from: aFromIndex to: aToIndex [ 

	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].
		
	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].


	self text
		attributes: anAttributesCollection
		from: start + aFromIndex - 1
		to: start + aToIndex - 1
]

{ #category : #'text - attributes' }
BlSubText >> clearAttributes: aBlock [
	text
		clearAttributes: start
		to: end
		if: aBlock
]

{ #category : #'text - attributes' }
BlSubText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	text
		clearAttributes: start + aFromIndex - 1
		to: start + aToIndex - 1
		if: aBlock
]

{ #category : #'text - modifications' }
BlSubText >> delete: aStart to: anEnd [
	text delete: start + aStart - 1 to: start + anEnd - 1.
	end := end - (anEnd - aStart + 1)
]

{ #category : #'text - enumeration' }
BlSubText >> do: aBlockClosure [ 
	| anIterator |
	anIterator := self iterator.
	[ anIterator hasNext ] whileTrue: [ aBlockClosure value: anIterator next ]
]

{ #category : #'text - accessing' }
BlSubText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self text empty
]

{ #category : #accessing }
BlSubText >> end [
	<return: #Number>

	^ end
]

{ #category : #accessing }
BlSubText >> end: anIndex [ 
	self 
		deprecated: 'Use start:end: instead'
		on: 	'7 August 2017' 
		in: 'Pharo-7.0-0-SNAPSHOT'.
	^ self start: start end: anIndex 
]

{ #category : #'text - accessing' }
BlSubText >> from: aStart to: anEnd [
	self assertInvariant.
	
	self
		assert: [ self isNotEmpty or: [ aStart isZero and: [ anEnd isZero ] ] ]
		description: [ 'If I am empty both start and end must be zero' ].
	
	^ self text
		from: ((aStart + start - 1) max: 0)
		to: ((anEnd + start - 1) max: 0)
]

{ #category : #'text - enumeration' }
BlSubText >> from: aFromIndex to: aToIndex do: aBlockClosure [
	| anIterator |
	anIterator := self iterator: aFromIndex to: aToIndex.
	[ anIterator hasNext ] whileTrue: [ aBlockClosure value: anIterator next ]
]

{ #category : #'text - copying' }
BlSubText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>
	
	^ self text generation
]

{ #category : #comparing }
BlSubText >> hash [
	^ ((self class hash bitXor: self start hash) bitXor: self end hash) bitXor: self text hash
]

{ #category : #'text - modifications' }
BlSubText >> insertString: aString at: anIndex [
	text insertString: aString at: start + anIndex - 1.
	end := end + aString size
]

{ #category : #accessing }
BlSubText >> insertText: arg1 at: arg2 [ 
	^ self shouldBeImplemented
]

{ #category : #'text - testing' }
BlSubText >> isEmpty [
	^ self size isZero
]

{ #category : #'text - enumeration' }
BlSubText >> iterator [
	^ BlSubTextIterator
		text: self
		from: (1 min: self size)
		to: self size
]

{ #category : #'text - enumeration' }
BlSubText >> iterator: aStartIndex to: anEndIndex [
	^ BlSubTextIterator
		text: self
		from: aStartIndex
		to: anEndIndex
]

{ #category : #copying }
BlSubText >> postCopy [
	super postCopy.
	text := text copy
]

{ #category : #'text - accessing' }
BlSubText >> size [
	self assertInvariant.

	^ (start = end and: [ start isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ end - start + 1 ]
]

{ #category : #accessing }
BlSubText >> start [
	<return: #Number>

	^ start
]

{ #category : #accessing }
BlSubText >> start: anIndex [
	self 
		deprecated: 'Use start:end: instead'
		on: 	'7 August 2017' 
		in: 'Pharo-7.0-0-SNAPSHOT'.
	^ self start: anIndex end: end 
]

{ #category : #initialization }
BlSubText >> start: aStartIndex end: anEndIndex [
	self assertStart: aStartIndex end: anEndIndex.

	start := aStartIndex.
	end := anEndIndex.
	
	self assertInvariant
]

{ #category : #'text - notifying' }
BlSubText >> suspendAnnouncementsWhile: aBlock [
	super suspendAnnouncementsWhile: [
		self text suspendAnnouncementsWhile: aBlock ]
]

{ #category : #accessing }
BlSubText >> text [
	^ text
]

{ #category : #initialization }
BlSubText >> text: aBrText from: aStartIndex to: anEndIndex [

	text := aBrText.
	start := aStartIndex.
	end := anEndIndex.
	
	self assertInvariant
]

{ #category : #'text - accessing' }
BlSubText >> textOffset [
	"Return absolute text offset to better deal with sub-texts"
	<return: #Number>
	
	^ ((self start - 1) max: 0) + self text textOffset
]

{ #category : #accessing }
BlSubText >> unstyle: aFromIndex to: aToIndex [
	self text unstyle: (start + aFromIndex - 1) to: (start + aToIndex - 1)
]
