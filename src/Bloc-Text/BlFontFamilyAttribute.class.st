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
BlFontFamilyAttribute >> equals: aTextAttribute [
	^ self name = aTextAttribute name
]

{ #category : #comparing }
BlFontFamilyAttribute >> hash [
	^ self class hash bitXor: self name hash
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
