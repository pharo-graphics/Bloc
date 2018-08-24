Class {
	#name : #BrFontFamilyAttribute,
	#superclass : #BrTextAttribute,
	#instVars : [
		'name'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BrFontFamilyAttribute class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #comparing }
BrFontFamilyAttribute >> equals: aTextAttribute [
	^ self name = aTextAttribute name
]

{ #category : #comparing }
BrFontFamilyAttribute >> hash [
	^ self class hash bitXor: self name hash
]

{ #category : #accessing }
BrFontFamilyAttribute >> name [
	^ name
]

{ #category : #accessing }
BrFontFamilyAttribute >> name: anObject [
	name := anObject
]

{ #category : #printing }
BrFontFamilyAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self name printString
]
