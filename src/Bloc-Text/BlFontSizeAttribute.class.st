"
I represent a font size attribute.
I am used together with `BlText` and `BlTextStyler` to style text.

Public API and Key Messages

- size: set font size in points

Example:

	BlFontSizeAttribute size: 20
 
Internal Representation and Key Implementation Points.

    Instance Variables
	size		<Number> 

"
Class {
	#name : #BlFontSizeAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'size'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlFontSizeAttribute class >> size: aNumber [
	^ self new
		size: aNumber;
		yourself
]

{ #category : #'text style' }
BlFontSizeAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder fontSize: self size
]

{ #category : #comparing }
BlFontSizeAttribute >> equals: anAnotherAttribute [
	^ self size = anAnotherAttribute size
]

{ #category : #comparing }
BlFontSizeAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self size hash
]

{ #category : #printing }
BlFontSizeAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-size: ';
		nextPutAll: self size asString
]

{ #category : #accessing }
BlFontSizeAttribute >> size [
	^ size
]

{ #category : #accessing }
BlFontSizeAttribute >> size: aNumber [
	self
		assert: [ size isNil ]
		description: [ 'I am immutable and can not be modified' ].

	size := aNumber
]

{ #category : #printing }
BlFontSizeAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream
		space;
		nextPutAll: #size: asString;
		space;
		store: size
]
