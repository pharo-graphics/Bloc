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
BlFontFamilyAttribute >> name: anObject [
	name := anObject
]

{ #category : #printing }
BlFontFamilyAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self name printString
]
