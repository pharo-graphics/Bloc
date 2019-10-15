"
I am a special type of ${BlText}$ with a guarantee that every item is a character
"
Class {
	#name : #BlCharacterText,
	#superclass : #BlWrappedText,
	#category : #'Bloc-Text-Text'
}

{ #category : #accessing }
BlCharacterText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>
	
	^ (super at: anIndex) asCharacter
]

{ #category : #'text - copying' }
BlCharacterText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.
	
	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	aStartIndex > anEndIndex
		ifTrue: [ ^ self empty ].

	^ (self from: aStartIndex to: anEndIndex) characters
]

{ #category : #'text - enumeration' }
BlCharacterText >> do: aBlock [
	"Evaluate aBlock with every character as argument"
	
	self text do: [ :eachItem | aBlock value: eachItem asCharacter ]
]

{ #category : #'text - enumeration' }
BlCharacterText >> from: aFromIndex to: aToIndex do: aBlock [
	"Evaluate aBlock with every character as argument within interval [aFromIndex, aToIndex]"
	
	self text from: aFromIndex to: aToIndex do: [ :eachItem | aBlock value: eachItem asCharacter ]
]
