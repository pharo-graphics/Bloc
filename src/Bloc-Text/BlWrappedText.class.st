"
I am a special type of text that delegates most operations to the underlying text that is wrapped by me

"
Class {
	#name : #BlWrappedText,
	#superclass : #BlText,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #testing }
BlWrappedText class >> isAbstract [
	^ self name = #BlWrappedText 
]

{ #category : #'instance creation' }
BlWrappedText class >> new [
	self error: 'Use one of my factories instead (e.g. #text:)'
]

{ #category : #'instance creation' }
BlWrappedText class >> text: aBlText [
	<return: #BlWrappedText>

	^ self basicNew
		initialize;
		text: aBlText
]

{ #category : #accessing }
BlWrappedText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>
	
	^ self text at: anIndex
]

{ #category : #'text - attributes' }
BlWrappedText >> attributes: anAttributesCollection [
	"Apply given attributes on the whole text"

	self text attributes: anAttributesCollection
]

{ #category : #'text - attributes' }
BlWrappedText >> attributes: anAttributesCollection from: aStart to: anEnd [
	"Apply given attributes on the text from aStart to anEnd"

	self text attributes: anAttributesCollection from: aStart to: anEnd
]

{ #category : #'text - attributes' }
BlWrappedText >> attributesFinder [
	^ text attributesFinder
]

{ #category : #'text - attributes' }
BlWrappedText >> clearAttributes: aStart to: anEnd if: aBlock [
	self text clearAttributes: aStart to: anEnd if: aBlock
]

{ #category : #'text - copying' }
BlWrappedText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.
	
	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	^ self text copyFrom: aStartIndex to: anEndIndex
]

{ #category : #'text - enumeration' }
BlWrappedText >> do: aBlock [
	"Evaluate aBlock with every character as argument"
	
	self text do: aBlock
]

{ #category : #'text - accessing' }
BlWrappedText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self text empty
]

{ #category : #'instance creation' }
BlWrappedText >> from: aFromIndex to: aToIndex do: aBlock [
	"Evaluate aBlock with every character as argument within interval [aFromIndex, aToIndex]"
	
	self text from: aFromIndex to: aToIndex do: aBlock
]

{ #category : #'text - copying' }
BlWrappedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self text generation
]

{ #category : #'text - testing' }
BlWrappedText >> isEmpty [
	
	^ self text isEmpty
]

{ #category : #'text - enumeration' }
BlWrappedText >> iterator [
	"Return an iterator pointing to the first text item (character) limited only by the text size"
	<return: #BlTextIterator>
	
	^ self text iterator
]

{ #category : #'text - enumeration' }
BlWrappedText >> iterator: aStartIndex to: anEndIndex [
	"Return an iterator pointing to the character at anStartIndex and limited by anEndIndex"
	<return: #BlTextIterator>

	^ self text iterator: aStartIndex to: anEndIndex
]

{ #category : #'text - accessing' }
BlWrappedText >> size [

	^ self text size
]

{ #category : #'text - notifying' }
BlWrappedText >> suspendAnnouncementsWhile: aBlock [
	super suspendAnnouncementsWhile: [
		self text suspendAnnouncementsWhile: aBlock ]
]

{ #category : #accessing }
BlWrappedText >> text [

	^ text
]

{ #category : #accessing }
BlWrappedText >> text: aBlText [
	self
		assert: [ text isNil ]
		description: [ 'Can not change text once it is set. Create a new instance instead' ].
		
	text := aBlText
]

{ #category : #'text - attributes' }
BlWrappedText >> unstyle: aFromIndex to: aToIndex [
	"Clear all style related attributes within interval defined by from and to indices"
	
	self text unstyle: aFromIndex to: aToIndex
]
