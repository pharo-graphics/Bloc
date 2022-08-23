Class {
	#name : #BlEmptyText,
	#superclass : #BlText,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #cleanup }
BlEmptyText class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlEmptyText class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'text - accessing' }
BlEmptyText >> at: anIndex [
	"Return an item at a given index"
	<return: #Object>
	
	^ self errorSubscriptBounds: anIndex 
]

{ #category : #'text - attributes' }
BlEmptyText >> attributes: anAttributesCollection [
]

{ #category : #'text - attributes' }
BlEmptyText >> attributes: anAttributesCollection from: aStart to: anEnd [
	"Apply given attributes on the text from aStart to anEnd"
]

{ #category : #'text - attributes' }
BlEmptyText >> attributesFinder [
	^ BlTextAttributesIgnoringFinder new
]

{ #category : #'text - attributes' }
BlEmptyText >> clearAttributes: aStart to: anEnd if: aBlock [

]

{ #category : #'text - copying' }
BlEmptyText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.
	
	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	^ self
]

{ #category : #'text - modifications' }
BlEmptyText >> deleteAll: aCollectionOfIntervals [
]

{ #category : #'text - enumeration' }
BlEmptyText >> do: aBlock [
]

{ #category : #'text - accessing' }
BlEmptyText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self
]

{ #category : #'text - converting' }
BlEmptyText >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode myself on a ByteString stream using the provided Zinc encoder."
	

]

{ #category : #'text - enumeration' }
BlEmptyText >> from: aFromIndex to: aToIndex do: aBlock [
]

{ #category : #'text - copying' }
BlEmptyText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self 
]

{ #category : #'text - modifications' }
BlEmptyText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
]

{ #category : #'text - modifications' }
BlEmptyText >> insertText: aString at: anIndex [
]

{ #category : #'text - testing' }
BlEmptyText >> isEmpty [
	<return: #Boolean>

	^ true
]

{ #category : #'text - enumeration' }
BlEmptyText >> iterator [
	"Return an iterator pointing to the first text item (character) limited only by the text size"
	<return: #BlTextIterator>

	^ BlEmptyTextIterator new
]

{ #category : #'text - enumeration' }
BlEmptyText >> iterator: aStartIndex to: anEndIndex [
	<return: #BlTextIterator>
	
	self
		assert: [ aStartIndex isZero and: [ aStartIndex = anEndIndex ] ]
		description: [ 'Start end end indices for empty iterator must be 0' ].
	
	^ BlEmptyTextIterator new
]

{ #category : #'text - accessing' }
BlEmptyText >> size [
	<return: #Number>

	^ 0
]

{ #category : #'text - attributes' }
BlEmptyText >> unstyle: aFromIndex to: aToIndex [
]
