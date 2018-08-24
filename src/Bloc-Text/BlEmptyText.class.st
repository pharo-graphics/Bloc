Class {
	#name : #BlEmptyText,
	#superclass : #BlText,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Text-Text'
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

{ #category : #'text - attributes' }
BlEmptyText >> attributes: anAttributesCollection [
]

{ #category : #'text - modifications' }
BlEmptyText >> delete: aStart to: anEnd [
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

{ #category : #'text - enumeration' }
BlEmptyText >> from: aFromIndex to: aToIndex do: aBlock [
]

{ #category : #'text - modifications' }
BlEmptyText >> insertString: aString at: anIndex [
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
