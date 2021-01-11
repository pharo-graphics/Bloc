Class {
	#name : #BlFontStyle,
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
	#category : #'Bloc-Text-Font'
}

{ #category : #'instance creation' }
BlFontStyle class >> fromNumber: aNumber [
	<return: #SpartaFontSlant>
	Slants
		ifNil: [ Slants := (self classPool values
				select: [ :eachValue | eachValue isKindOf: self ]
				thenCollect: [ :eachSlant | eachSlant value -> eachSlant ])
				as: Dictionary ].
	^ Slants at: aNumber ifAbsent: [ self slant: aNumber name: #custom ]
]

{ #category : #'class initialization' }
BlFontStyle class >> initialize [
	Normal := self slant: 0 name: #normal.
	Italic := self slant: 1 name: #italic.
	Oblique := self slant: 2 name: #oblique
]

{ #category : #accessing }
BlFontStyle class >> italic [
	^ Italic
]

{ #category : #accessing }
BlFontStyle class >> normal [
	^ Normal
]

{ #category : #accessing }
BlFontStyle class >> oblique [
	^ Oblique
]

{ #category : #'instance creation' }
BlFontStyle class >> slant: aSlantValue name: aSlantName [
	^ self new
		value: aSlantValue;
		name: aSlantName
]

{ #category : #comparing }
BlFontStyle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value
]

{ #category : #comparing }
BlFontStyle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash
]

{ #category : #accessing }
BlFontStyle >> name [
	<return: #Symbol>

	^ name
]

{ #category : #accessing }
BlFontStyle >> name: aSymbol [
	name := aSymbol
]

{ #category : #printing }
BlFontStyle >> printOn: aStream [
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
BlFontStyle >> value [
	<return: #Number>

	^ value
]

{ #category : #accessing }
BlFontStyle >> value: aNumber [
	value := aNumber
]
