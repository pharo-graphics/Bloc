Class {
	#name : #BlFontFamilyAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'name'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlFontFamilyAttribute class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #'text style' }
BlFontFamilyAttribute >> applyOnTextStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder familyName: self name
]

{ #category : #comparing }
BlFontFamilyAttribute >> equals: anAnotherAttribute [
	^ self name = anAnotherAttribute name
]

{ #category : #comparing }
BlFontFamilyAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self name hash
]

{ #category : #accessing }
BlFontFamilyAttribute >> name [
	^ name
]

{ #category : #accessing }
BlFontFamilyAttribute >> name: aString [	
	self
		assert: [ name isNil ]
		description: [ 'I am immutable and can not be modified' ].

	name := aString
]

{ #category : #printing }
BlFontFamilyAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self name printString
]

{ #category : #printing }
BlFontFamilyAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream
		space;
		nextPutAll: #name: asString;
		space;
		store: name
]
