Class {
	#name : 'BlFontStretch',
	#superclass : 'SharedPool',
	#instVars : [
		'name',
		'value'
	],
	#classVars : [
		'Condensed',
		'Expanded',
		'ExtraCondensed',
		'ExtraExpanded',
		'Normal',
		'SemiCondensed',
		'SemiExpanded',
		'UltraCondensed',
		'UltraExpanded'
	],
	#package : 'Bloc',
	#tag : 'Text-Font',
	#package : 'Bloc-Text',
	#tag : 'Font'
}

{ #category : 'accessing' }
BlFontStretch class >> condensed [
	^ Condensed
]

{ #category : 'accessing' }
BlFontStretch class >> expanded [
	^ Expanded
]

{ #category : 'accessing' }
BlFontStretch class >> extraCondensed [
	^ ExtraCondensed
]

{ #category : 'accessing' }
BlFontStretch class >> extraExpanded [
	^ ExtraExpanded
]

{ #category : 'class initialization' }
BlFontStretch class >> initialize [
	UltraCondensed := self stretch: 0 name: #ultraCondensed.
	ExtraCondensed := self stretch: 1 name: #extraCondensed.
	Condensed := self stretch: 2 name: #condensed.
	SemiCondensed := self stretch: 3 name: #semiCondensed.
	Normal := self stretch: 4 name: #normal.
	SemiExpanded := self stretch: 5 name: #semiExpanded.
	Expanded := self stretch: 6 name: #expanded.
	ExtraExpanded := self stretch: 7 name: #extraExpanded.
	UltraExpanded := self stretch: 8 name: #ultraExpanded.
]

{ #category : 'accessing' }
BlFontStretch class >> normal [
	^ Normal
]

{ #category : 'accessing' }
BlFontStretch class >> semiCondensed [
	^ SemiCondensed
]

{ #category : 'accessing' }
BlFontStretch class >> semiExpanded [
	^ SemiExpanded
]

{ #category : 'instance creation' }
BlFontStretch class >> stretch: aStretchValue name: aStretchName [
	^ self new
		value: aStretchValue;
		name: aStretchName
]

{ #category : 'accessing' }
BlFontStretch class >> ultraCondensed [
	^ UltraCondensed
]

{ #category : 'accessing' }
BlFontStretch class >> ultraExpanded [
	^ UltraExpanded
]

{ #category : 'comparing' }
BlFontStretch >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value
]

{ #category : 'comparing' }
BlFontStretch >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash
]

{ #category : 'accessing' }
BlFontStretch >> name [
	<return: #Symbol>

	^ name
]

{ #category : 'accessing' }
BlFontStretch >> name: aSymbol [
	name := aSymbol
]

{ #category : 'printing' }
BlFontStretch >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' name: ';
		print: name.
	aStream
		nextPutAll: ' value: ';
		print: value
]

{ #category : 'evaluating' }
BlFontStretch >> value [
	<return: #Number>

	^ value
]

{ #category : 'accessing' }
BlFontStretch >> value: aNumber [
	value := aNumber
]
