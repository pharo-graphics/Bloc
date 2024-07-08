"
I represent a text foreground attribute.
I am used together with `BlText` and `BlTextStyler` to style text.

Public API and Key Messages

- paint: set foreground paint

Example:

	BlTextForegroundAttribute paint: Color blue
 
Internal Representation and Key Implementation Points.

    Instance Variables
	paint:		<Object> can be a Color, Pattern, Gradient. Basically anything that is knows how to convert itself to canvas specific paint

"
Class {
	#name : #BlTextForegroundAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'paint'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlTextForegroundAttribute class >> color: aColor [
	^ self new
		paint: aColor;
		yourself
]

{ #category : #'instance creation' }
BlTextForegroundAttribute class >> paint: aPaint [
	^ self color: aPaint
]

{ #category : #'text style' }
BlTextForegroundAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [

	aBlTextFontAndStyleBuilder color: self paint
]

{ #category : #comparing }
BlTextForegroundAttribute >> equals: anAnotherAttribute [
	^ self paint = anAnotherAttribute paint
]

{ #category : #comparing }
BlTextForegroundAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self paint hash
]

{ #category : #accessing }
BlTextForegroundAttribute >> paint [
	^ paint
]

{ #category : #accessing }
BlTextForegroundAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].
		
	self
		assert: [ aPaint isColor ]
		description: [ 'Foreground must be a color' ].

	paint := aPaint
]

{ #category : #printing }
BlTextForegroundAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-foreground: ';
		nextPutAll: self paint printString
]

{ #category : #printing }
BlTextForegroundAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream
		space;
		nextPutAll: #paint: asString;
		space;
		store: paint
]
