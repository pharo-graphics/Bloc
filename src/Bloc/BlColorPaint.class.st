"
I am a concrete type of BlPaint that is just represented as a Color.

Color paint is transparent then and only then when underlying color's alpha channel is 0

"
Class {
	#name : #BlColorPaint,
	#superclass : #BlPaint,
	#instVars : [
		'color'
	],
	#category : #'Bloc-Paint'
}

{ #category : #'instance creation' }
BlColorPaint class >> color: aColor [

	^ self new
		color: aColor;
		yourself
]

{ #category : #comparing }
BlColorPaint >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	(anotherObject class = self class) ifFalse: [ ^ false ].

	^ anotherObject color = self color
]

{ #category : #accessing }
BlColorPaint >> color [
	"Return paint's underlying color.
	color can not be nil"
	<return: #Color>
	
	self
		assert: [ color isNotNil ]
		description: [ 'Color can not be nil' ].
	
	^ color
]

{ #category : #accessing }
BlColorPaint >> color: aColor [
	"Initialize me with a given Color"
	self
		assert: [ color isNil ]
		description: [ 'Color paint is immutable!' ].

	color := aColor
]

{ #category : #comparing }
BlColorPaint >> hash [

	^ super hash bitXor: color hash
]

{ #category : #testing }
BlColorPaint >> isColorPaint [

	^ true
]

{ #category : #testing }
BlColorPaint >> isOpaque [
	"Color paint is opaque when underlying color is opaque
	@see `BlPaint>>#isOpaque`"

	^ color isOpaque
]

{ #category : #testing }
BlColorPaint >> isTransparent [
	"Color paint is transparent when underlying color is transparent
	@see BlPaint>>#isTransparent"

	^ color isTransparent
]

{ #category : #geometry }
BlColorPaint >> matchExtent: anExtent [
	"do nothing for color paint"
]

{ #category : #printing }
BlColorPaint >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: color;
		nextPutAll: ')'
]
