Class {
	#name : #BlFontSlant,
	#superclass : #SharedPool,
	#instVars : [
		'name',
		'value'
	],
	#classVars : [
		'Italic',
		'Normal',
		'Oblique',
		'Slants'
	],
	#category : 'Bloc-Text-Font'
}

{ #category : #'instance creation' }
BlFontSlant class >> fromNumber: aNumber [
	<return: #BlFontSlant>
	Slants
		ifNil: [ Slants := (self classPool values
				select: [ :eachValue | eachValue isKindOf: self ]
				thenCollect: [ :eachSlant | eachSlant value -> eachSlant ])
				as: Dictionary ].
	^ Slants at: aNumber ifAbsent: [ self slant: aNumber name: #custom ]
]

{ #category : #'class initialization' }
BlFontSlant class >> initialize [
	Normal := self slant: 0 name: #normal.
	Italic := self slant: 1 name: #italic.
	Oblique := self slant: 2 name: #oblique
]

{ #category : #accessing }
BlFontSlant class >> italic [
	^ Italic
]

{ #category : #accessing }
BlFontSlant class >> normal [
	^ Normal
]

{ #category : #accessing }
BlFontSlant class >> oblique [
	^ Oblique
]

{ #category : #'instance creation' }
BlFontSlant class >> slant: aSlantValue name: aSlantName [
	^ self new
		value: aSlantValue;
		name: aSlantName
]

{ #category : #comparing }
BlFontSlant >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value
]

{ #category : #comparing }
BlFontSlant >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash
]

{ #category : #accessing }
BlFontSlant >> name [
	<return: #Symbol>

	^ name
]

{ #category : #accessing }
BlFontSlant >> name: aSymbol [
	name := aSymbol
]

{ #category : #printing }
BlFontSlant >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' value: ';
		print: value.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : #accessing }
BlFontSlant >> value [
	<return: #Number>

	^ value
]

{ #category : #accessing }
BlFontSlant >> value: aNumber [
	value := aNumber
]
