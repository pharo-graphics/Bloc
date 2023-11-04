Class {
	#name : 'BlFontWeight',
	#superclass : 'SharedPool',
	#instVars : [
		'name',
		'value'
	],
	#classVars : [
		'Black',
		'Bold',
		'ExtraBlack',
		'ExtraBold',
		'ExtraLight',
		'Invisible',
		'Light',
		'Medium',
		'Normal',
		'SemiBold',
		'Thin',
		'Weights'
	],
	#package : 'Bloc',
	#tag : 'Text-Font',
	#package : 'Bloc-Text',
	#tag : 'Font'
}

{ #category : 'accessing' }
BlFontWeight class >> black [
	^ Black
]

{ #category : 'accessing' }
BlFontWeight class >> bold [
	^ Bold
]

{ #category : 'accessing' }
BlFontWeight class >> extraBlack [
	^ ExtraBlack
]

{ #category : 'accessing' }
BlFontWeight class >> extraBold [
	^ ExtraBold
]

{ #category : 'accessing' }
BlFontWeight class >> extraLight [
	^ ExtraLight
]

{ #category : 'class initialization' }
BlFontWeight class >> fromNumber: aNumber [
	<return: #BlFontWeight>
	Weights
		ifNil: [ Weights := (self classPool values
				select: [ :eachValue | eachValue isKindOf: self ]
				thenCollect: [ :eachWeight | eachWeight value -> eachWeight ])
				as: Dictionary ].
	^ Weights
		at: aNumber
		ifAbsent: [ self weight: aNumber name: #custom ]
]

{ #category : 'class initialization' }
BlFontWeight class >> initialize [
	Invisible := self weight: 0 name: #invisible.
	Thin := self weight: 100 name: #thin.
	ExtraLight := self weight: 200 name: #extraLight.
	Light := self weight: 300 name: #light.
	Normal := self weight: 400 name: #normal.
	Medium := self weight: 500 name: #medium.
	SemiBold := self weight: 600 name: #semiBold.
	Bold := self weight: 700 name: #bold.
	ExtraBold := self weight: 800 name: #extraBold.
	Black := self weight: 900 name: #black.
	ExtraBlack := self weight: 1000 name: #extraBlack.
]

{ #category : 'accessing' }
BlFontWeight class >> invisible [
	^ Invisible
]

{ #category : 'accessing' }
BlFontWeight class >> light [
	^ Light
]

{ #category : 'accessing' }
BlFontWeight class >> medium [
	^ Medium
]

{ #category : 'accessing' }
BlFontWeight class >> normal [
	^ Normal
]

{ #category : 'accessing' }
BlFontWeight class >> semiBold [
	^ SemiBold
]

{ #category : 'accessing' }
BlFontWeight class >> thin [
	^ Thin
]

{ #category : 'instance creation' }
BlFontWeight class >> weight: aWeightValue name: aWeightName [
	^ self new
		value: aWeightValue;
		name: aWeightName
]

{ #category : 'comparing' }
BlFontWeight >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value
]

{ #category : 'comparing' }
BlFontWeight >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash
]

{ #category : 'accessing' }
BlFontWeight >> name [
	<return: #Symbol>

	^ name
]

{ #category : 'accessing' }
BlFontWeight >> name: aSymbol [
	name := aSymbol
]

{ #category : 'printing' }
BlFontWeight >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' value: ';
		print: value.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : 'accessing' }
BlFontWeight >> value [
	<return: #Number>

	^ value
]

{ #category : 'accessing' }
BlFontWeight >> value: aNumber [
	value := aNumber
]
