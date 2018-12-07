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
	#category : 'Bloc-Text-Rope-Text'
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
	<return: #Boolean>
	
	^ iterator hasNext
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> next [
	"Return an item (character) at current position and move one to the right"
	<return: #Character or: #Object>

	^ iterator next
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextLine [
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>
	| aStartPosition aNextLine |
	
	aStartPosition := iterator position.
	aNextLine := iterator nextLine.

	^ BlSubText text: text from: aStartPosition to: ((aStartPosition + aNextLine size - 1) max: aStartPosition)
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s) CR, LF or CRLF"
		
	iterator nextLineIndicesDo: anIndicesBlock
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextSegment: aBlock [
	<return: #BlText>
	| aStartPosition aSegment |

	aStartPosition := iterator position.
	aSegment := iterator nextSegment: aBlock.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1
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
	"Return an instance of BrText which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>

	^ BlRopedText rope: iterator nextWhitespace
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> nextWord [
	"Return an instance of BrText which represents a piece of text from current position
	until the first space character not including spaces"
	<return: #BlText>
	| aStartPosition aSegment |
	
	aStartPosition := iterator position.
	aSegment :=  iterator nextWord.

	^ BlSubText text: text from: aStartPosition to: aStartPosition + aSegment size - 1	

	"^ BrRopedText rope: iterator nextWord"
]

{ #category : #'iterator - enumeration' }
BlRopedTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ iterator peek
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

{ #category : #accessing }
BlRopedTextIterator >> rope [
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

{ #category : #accessing }
BlRopedTextIterator >> text [
	^ text
]

{ #category : #accessing }
BlRopedTextIterator >> text: aBrRopedText from: aStartIndex to: anEndIndex [
	rope := aBrRopedText rope.
	text := aBrRopedText.
	iterator := rope iterator: aStartIndex to: anEndIndex
]
