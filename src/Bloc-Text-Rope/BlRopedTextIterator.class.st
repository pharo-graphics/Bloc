"
I am a specific RopedText iterator

"
Class {
	#name : #BlRopedTextIterator,
	#superclass : #BlTextIterator,
	#instVars : [
		'rope',
		'iterator',
		'text'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRopedTextIterator class >> text: aRopedText [
	
	^ self new
		text: aRopedText from: (1 min: aRopedText size) to: aRopedText size;
		yourself
]

{ #category : #'instance creation' }
BlRopedTextIterator class >> text: aRopedText from: aStartIndex to: anEndIndex [
	
	^ self new
		text: aRopedText from: aStartIndex to: anEndIndex;
		yourself
]

{ #category : #'iterator - accessing' }
BlRopedTextIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #BlTextAttribute>

	^ iterator attributes
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ iterator detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock
]

{ #category : #'iterator - testing' }
BlRopedTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"
	
	^ iterator hasNext
]

{ #category : #'iterator - testing' }
BlRopedTextIterator >> hasPrevious [
	"Return true if there is a previous text item (character) before the current position"
	<return: #Boolean>

	^ iterator hasPrevious
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> next [
	"Return an item (character) at current position and move one to the right"

	^ iterator next
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextLine [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>
	
	^ self nextLineIndicesDo: [ :aStart :anEnd | BlSubText text: text from: aStart to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line in text coordinates
		- end index of line without line delimiter in text coordinates
		- end index of line including line delimiter(s) in text coordinates"

	^ iterator nextLineIndicesDo: [ :aStart :anEnd :aLineEndWithDelimiters |
		anIndicesBlock cull: aStart + 1 cull: anEnd cull: aLineEndWithDelimiters ]
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextSegment: aBlock [
	<return: #BlText>

	^ iterator
		nextSegment: aBlock
		indicesDo: [ :aStart :anEnd | BlSubText text: text from: ((aStart + 1) min: anEnd) to: anEnd ]
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#nextSegment:indicesDo:"
	<return: #Object>
	
	^ iterator nextSegment: aBlock indicesDo: anIndicesBlock
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextSpan [
	"Return a next homogeneous text span"
	<return: #BlSpan>
	| theAttributes |
	
	theAttributes := iterator attributes.
	
	^ BlSpan
		text: (BlRopedText rope: iterator nextSpan)
		attributes: theAttributes
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextWhitespace [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position + 1.
	aSegment :=  iterator nextWhitespace.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextWord [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first space character not including spaces"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position + 1.
	aSegment :=  iterator nextWord.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ iterator peek
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> peer [
	"Return an item (character) before current position"
	<return: #Character or: #Object>

	^ iterator peer
]

{ #category : #'iterator - accessing' }
BlRopedTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ iterator position
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> previous [
	"Return an item (character) at current position and move one to the left"
	<return: #Character or: #Object>

	^ iterator previous
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> previousSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#previousSegment:indicesDo:"
	<return: #Object>
	
	^ iterator previousSegment: aBlock indicesDo: anIndicesBlock
]

{ #category : #accessing }
BlRopedTextIterator >> rope [
	<return: #BlRope>

	^ rope
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ iterator selectAttributes: aBlock
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> skip: aNumber [
	"Move forward by aNumber characters"

 	iterator skip: aNumber
]

{ #category : #accessing }
BlRopedTextIterator >> text [
	<return: #BlRopedText>

	^ text
]

{ #category : #accessing }
BlRopedTextIterator >> text: aBlRopedText from: aStartIndex to: anEndIndex [

	rope := aBlRopedText rope.
	text := aBlRopedText.

	iterator := rope iterator: ((aStartIndex - 1) max: 0) to: anEndIndex
]
