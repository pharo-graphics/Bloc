Class {
	#name : #BlFontFamilyDefaultAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'name'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlFontFamilyDefaultAttribute class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #'text style' }
BlFontFamilyDefaultAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder defaultFamilyName: self name
]

{ #category : #comparing }
BlFontFamilyDefaultAttribute >> equals: anAnotherAttribute [
	^ self name = anAnotherAttribute name
]

{ #category : #comparing }
BlFontFamilyDefaultAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self name hash
]

{ #category : #accessing }
BlFontFamilyDefaultAttribute >> name [
	^ name
]

{ #category : #accessing }
BlFontFamilyDefaultAttribute >> name: aString [	
	self
		assert: [ name isNil ]
		description: [ 'I am immutable and can not be modified' ].

	name := aString
]

{ #category : #printing }
BlFontFamilyDefaultAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-family-default: ';
		nextPutAll: self name printString
]

{ #category : #printing }
BlFontFamilyDefaultAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream
		space;
		nextPutAll: #name: asString;
		space;
		store: name
]
