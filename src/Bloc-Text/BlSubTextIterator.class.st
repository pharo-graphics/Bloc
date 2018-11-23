Class {
	#name : #BlSubTextIterator,
	#superclass : #BlTextIterator,
	#instVars : [
		'text',
		'iterator'
	],
	#category : 'Bloc-Text-Text'
}

{ #category : #initialization }
BlSubTextIterator class >> text: aBrSubText from: aStartIndex to: anEndIndex [

	^ self new
		text: aBrSubText from: aStartIndex to: anEndIndex;
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
	^ ((self text text attributesAt: self position + self text textOffset) includes: anAttribute) not
]

{ #category : #'iterator - testing' }
BlSubTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"
	<return: #Boolean>

	^ iterator hasNext
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> next [
	"Return a next item (character) at current position and move one to the right"
	<return: #Character or: #Object>

	^ iterator next
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextLine [
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>

	^ iterator nextLine
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s) CR, LF or CRLF"
		
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
BlSubTextIterator >> nextSpan [
	"Return a next homogeneous text span"
	<return: #BlSpan>
	
	^ iterator nextSpan
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextWhitespace [
	"Return an instance of BrText which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>

	^ iterator nextWhitespace
]

{ #category : #'iterator - enumeration' }
BlSubTextIterator >> nextWord [
	"Return an instance of BrText which represents a piece of text from current position
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
BlSubTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ iterator selectAttributes: aBlock
]

{ #category : #accessing }
BlSubTextIterator >> text [
	^ text
]

{ #category : #initialization }
BlSubTextIterator >> text: aBrSubText from: aStartIndex to: anEndIndex [
	
	self
		assert: [ aStartIndex isInteger and: [ anEndIndex isInteger ] ]
		description: [ 'Only integers are alowed as start and end indices' ].
	self
		assert: [ aBrSubText isNotNil ]
		description: [ 'Text must not be nil' ].
	self
		assert: [ aStartIndex between: 0 and: aBrSubText size ]
		description: [ 'Sub-text start index is out of bounds!' ].
	self
		assert: [ anEndIndex between: 0 and: aBrSubText size ]
		description: [ 'Sub-text end index is out of bounds!' ].
	self
		assert: [ aBrSubText isNotEmpty or: [ aStartIndex isZero and: [ anEndIndex isZero ] ] ]
		description: [ 'If text is empty, start and end indices must be Zero!' ].
	self
		assert: [ aStartIndex isZero not or: [ anEndIndex isZero ] ]
		description: [ 'If start index is zero then end index must also be zero' ].
	self
		assert: [ anEndIndex isZero not or: [ aStartIndex isZero ] ]
		description: [ 'If end index is zero then start index must also be zero' ].
		
	
	text := aBrSubText.
	
	iterator := aBrSubText text
		iterator: ((aStartIndex + text start - 1) max: 0)
		to: ((anEndIndex + text start - 1) max: 0)
]
