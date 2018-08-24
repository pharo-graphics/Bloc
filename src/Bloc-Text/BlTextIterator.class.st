"
I define a data structure independent text iterator api.

Use me for text enumeration purposes
"
Class {
	#name : #BlTextIterator,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Text-Text'
}

{ #category : #'iterator - enumeration' }
BlTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BrTextAttribute or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'iterator - testing' }
BlTextIterator >> isNewLine: anItem [
	"Return true of given item represents a carriage return, false otherwise"
	<return: #Boolean>

	^ anItem = Character cr or: [ anItem = Character lf ]
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> next [
	"Return a next item (character) at current position and move one to the right"
	<return: #Character or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextLine [
	"Return an instance of BrText which represents a piece of text from current position
	until the first carriage return character"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextLineIndicesDo: anIndicesBlock [
	" execute anIndicesBlock with 3 arguments for each line:
		- start index of line
		- end index of line without line delimiter
		- end index of line including line delimiter(s) CR, LF or CRLF"
		
	self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSegment: aBlock [
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextSpan [
	"Return a next homogeneous text span"
	<return: #BlSpan>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextWhitespace [
	"Return an instance of BrText which represents a piece of text from current position
	until the first non-whitespace character without including it"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> nextWord [
	"Return an instance of BrText which represents a piece of text from current position
	until the first space character"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> peek [
	"Return an item (character) at current position"
	<return: #Character or: #Object>

	^ self subclassResponsibility
]

{ #category : #'iterator - accessing' }
BlTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'iterator - enumeration' }
BlTextIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BrTextAttribute>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextIterator >> text [
	"Return an original text that I iterate over"
	<return: #BlText>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextIterator >> text: arg1 from: arg2 to: arg3 [ 
	^ self subclassResponsibility
]
