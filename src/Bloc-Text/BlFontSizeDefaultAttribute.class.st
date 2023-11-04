Class {
	#name : 'BlFontSizeDefaultAttribute',
	#superclass : 'BlTextAttribute',
	#instVars : [
		'size'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Attributes',
	#package : 'Bloc-Text',
	#tag : 'Text-Attributes'
}

{ #category : 'instance creation' }
BlFontSizeDefaultAttribute class >> size: aNumber [
	^ self new
		size: aNumber;
		yourself
]

{ #category : 'text style' }
BlFontSizeDefaultAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder defaultFontSizePt: self size value
]

{ #category : 'comparing' }
BlFontSizeDefaultAttribute >> equals: anAnotherAttribute [
	^ self size = anAnotherAttribute size
]

{ #category : 'comparing' }
BlFontSizeDefaultAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self size hash
]

{ #category : 'printing' }
BlFontSizeDefaultAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-size-default: ';
		nextPutAll: self size asString
]

{ #category : 'accessing' }
BlFontSizeDefaultAttribute >> size [
	^ size
]

{ #category : 'accessing' }
BlFontSizeDefaultAttribute >> size: aNumber [
	self
		assert: [ size isNil ]
		description: [ 'I am immutable and can not be modified' ].

	size := aNumber
]

{ #category : 'printing' }
BlFontSizeDefaultAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream
		space;
		nextPutAll: #size: asString;
		space;
		store: size
]
