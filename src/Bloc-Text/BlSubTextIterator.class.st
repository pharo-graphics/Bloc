Class {
	#name : #BlSubTextIterator,
	#superclass : #BlTextIterator,
	#instVars : [
		'text',
		'iterator'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #initialization }
BlSubTextIterator class >> text: aBlSubText from: aStartIndex to: anEndIndex [

	^ self new
		text: aBlSubText from: aStartIndex to: anEndIndex;
		yourself
]

{ #category : #'iterator - accessing' }
BlSubTextIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #BlTextAttribute>

	^ iterator attributes
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ iterator detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock
]

{ #category : #'iterator - testing' }
BlSubTextIterator >> doesAttributeEnd: anAttribute [
	"Return true if a given attribute ends at the current position.
	By `ends` we mean that this attribute is not present at the next position.
	
	Implementation detail:
	 - we should not rely on the iterator scope, otherwise it will give us false positives on the edge of the scope for attributes that don't really end there."
	<return: #Boolean>
	
	"we are at the last character, so the attribute definitely ends here"
	(self position + self text textOffset) >= self text text size
		ifTrue: [ ^ true ].
	
	(self attributes includes: anAttribute)
		ifFalse: [ ^ true ].
	
	"check if this attribute exists at the next position, if not - it ends here"
	^ ((self text text attributesAt: self position + self text textOffset + 1) includes: anAttribute) not
]

{ #category : #'iterator - testing' }
BlSubTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"

	^ iterator hasNext
]

{ #category : #'iterator - testing' }
BlSubTextIterator >> hasPrevious [
	"Return true if there is a previous text item (character) before the current position"
	<return: #Boolean>

	^ iterator hasNext
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> next [
	"Return an item (character) at current position and move one to the right"

	^ iterator next
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextLine [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>

	^ iterator nextLine
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line in text coordinates
		- end index of line without line delimiter in text coordinates
		- end index of line including line delimiter(s) in text coordinates"
		
	iterator nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd |
		anIndicesBlock
			value: aLineStart - self text textOffset
			value: aLineEnd - self text textOffset
			value: aLineDelimiterEnd - self text textOffset ]
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextSegment: aBlock [
	<return: #BlText>

	^ iterator nextSegment: aBlock
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextSegment: aBlock indicesDo: anIndicesBlock [
	"@see BlTextIterator>>#nextSegment:indicesDo:"
	<return: #Object>
		
	^ iterator nextSegment: aBlock indicesDo: [ :aSegmentStart :aSegmentEnd :anInitialValue |
		anIndicesBlock
			cull: aSegmentStart - self text textOffset
			cull: aSegmentEnd - self text textOffset
			cull: anInitialValue ]
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextSpan [
	"Return a next homogeneous text span"
	<return: #BlSpan>
	
	^ iterator nextSpan
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextWhitespace [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>

	| aStartPosition aSegment |
	
	aStartPosition := iterator position + 1.
	aSegment :=  iterator nextWhitespace.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextWord [
	"Return an instance of `BlText` which represents a piece of text from current position
	until the first space character"
	<return: #BlText>

	^ iterator nextWord
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ iterator peek
]

{ #category : #'iterator - accessing' }
BlSubTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ iterator position - text start + 1
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> previous [
	"Return an item (character) at current position and move one to the left"
	<return: #Character or: #Object>

	^ iterator previous
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ iterator selectAttributes: aBlock
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> skip: aNumber [
	"Move forward by aNumber characters"

	iterator skip: aNumber
]

{ #category : #accessing }
BlSubTextIterator >> text [
	^ text
]

{ #category : #initialization }
BlSubTextIterator >> text: aBlSubText from: aStartIntegerIndex to: anEndIntegerIndex [
	"aStartIntegerIndex and anEndIntegerIndex are integers."

	self
		assert: [ aStartIntegerIndex between: 1 and: (aBlSubText size + 1) ]
		description: [ 'Sub-text start index is out of bounds!' ].
	self
		assert: [ anEndIntegerIndex between: 0 and: aBlSubText size ]
		description: [ 'Sub-text end index is out of bounds!' ].
	self
		assert: [ aBlSubText isNotEmpty or: [ aStartIntegerIndex = 1 and: [ anEndIntegerIndex isZero ] ] ]
		description: [ 'If text is empty, start must be 1 and end index must be Zero!' ].
	self
		assert: [ anEndIntegerIndex isZero not or: [ aStartIntegerIndex = 1 ] ]
		description: [ 'If end index is zero then start index must be one' ].

	text := aBlSubText.
	
	iterator := aBlSubText text
		iterator: ((aStartIntegerIndex + text start - 1) max: 0)
		to: ((anEndIntegerIndex + text start - 1) max: 0)
]
