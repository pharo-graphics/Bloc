Class {
	#name : 'BlEmptyTextIterator',
	#superclass : 'BlTextIterator',
	#category : 'Bloc-Text-Text',
	#package : 'Bloc-Text',
	#tag : 'Text'
}

{ #category : 'iterator - accessing' }
BlEmptyTextIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #BlTextAttribute>

	^ #()
]

{ #category : 'iterator - accessing' }
BlEmptyTextIterator >> cursorPosition [
	<return: #Number>
	
	^ 0
]

{ #category : 'iterator - enumeration' }
BlEmptyTextIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #Object>
	
	^ anExceptionBlock value
]

{ #category : 'testing' }
BlEmptyTextIterator >> hasNext [
	"Return true if there is a next text item (character) after a current position"
	<return: #Boolean>
	
	^ false
]

{ #category : 'iterator - testing' }
BlEmptyTextIterator >> hasPrevious [
	"Return true if there is a previous text item (character) before the current position"
	<return: #Boolean>

	^ false
]

{ #category : 'iterator - accessing' }
BlEmptyTextIterator >> position [
	"Return current iterator position within a text"
	<return: #Number>
	
	^ 0
]

{ #category : 'accessing' }
BlEmptyTextIterator >> text [
	"Return an original text that I iterate over"
	<return: #BlText>
	
	^ BlText empty
]
