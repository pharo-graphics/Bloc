"
! Underline
I represent a text underline attribute.
I am used together with ${class:BlText}$ and ${class:TBlTextStyleable}$ to style text.

https://en.wikipedia.org/wiki/Underline

See ${class:BlTextUnderlineAttributeExamples}$ for examples
"
Class {
	#name : #BlTextUnderlineAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'paint',
		'style',
		'width',
		'opacity',
		'below'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlTextUnderlineAttribute >> beAbove [
	below := false
]

{ #category : #accessing }
BlTextUnderlineAttribute >> beBelow [
	below := true
]

{ #category : #'accessing - stroke style' }
BlTextUnderlineAttribute >> dashArray: anArray [
	self style dashArray: anArray
]

{ #category : #'accessing - stroke style' }
BlTextUnderlineAttribute >> dashOffset: aNumber [
	self style dashOffset: aNumber
]

{ #category : #comparing }
BlTextUnderlineAttribute >> equals: anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ style = anObject style
		and: [ width = anObject width
				and: [ paint = anObject paint
						and: [ opacity = anObject opacity and: [ below = anObject isBelow ] ] ] ]
]

{ #category : #comparing }
BlTextUnderlineAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ style hash
		bitXor:
			(width hash
				bitXor: (paint hash bitXor: (opacity hash bitXor: below hash)))
]

{ #category : #initialization }
BlTextUnderlineAttribute >> initialize [
	super initialize.
	
	paint := Color black asBlPaint.
	below := true.
	opacity := 1.
	width := 2.
	style := BlStrokeStyle new
		lineCap: BlStrokeLineCap square;
		lineJoin: BlStrokeLineJoin round;
		miterLimit: 10.0;
		dashArray: #();
		dashOffset: 5
]

{ #category : #testing }
BlTextUnderlineAttribute >> isAbove [
	"Return true if underline should be rendered below a piece of text, false otherwise"
	<return: #Boolean>

	^ below not
]

{ #category : #testing }
BlTextUnderlineAttribute >> isBelow [
	"Return true if underline should be rendered below a piece of text"
	<return: #Boolean>

	^ below
]

{ #category : #'accessing - stroke style' }
BlTextUnderlineAttribute >> lineCap: aBlStrokeLineCap [
	self style lineCap: aBlStrokeLineCap
]

{ #category : #'accessing - stroke style' }
BlTextUnderlineAttribute >> lineJoin: aBlStrokeLineJoin [
	self style lineJoin: aBlStrokeLineJoin
]

{ #category : #'accessing - stroke style' }
BlTextUnderlineAttribute >> miterLimit: aNumber [
	self style miterLimit: aNumber
]

{ #category : #accessing }
BlTextUnderlineAttribute >> opacity [
	"Return number between 0 and 1"
	<return: #Number>
	^ opacity
]

{ #category : #accessing }
BlTextUnderlineAttribute >> opacity: aNumber [
	self 
		assert: [ aNumber notNil ] 
		description: [ 'Opacity must be non-nil' ].
	self 
		assert: [ aNumber >= 0 and: [ aNumber <= 1 ] ] 
		description: [ 'Opacity must be the interval <0.0; 1.0>' ].
	opacity := aNumber
]

{ #category : #accessing }
BlTextUnderlineAttribute >> paint [
	<return: #BlPaint>
	^ paint
]

{ #category : #accessing }
BlTextUnderlineAttribute >> paint: aPaint [
	self 
		assert: [ aPaint notNil ] 
		description: [ 'Paint must be non-nil' ].
	paint := aPaint asBlPaint
]

{ #category : #accessing }
BlTextUnderlineAttribute >> style [
	<return: #BlStrokeStyle>

	^ style
]

{ #category : #accessing }
BlTextUnderlineAttribute >> style: aBlStrokeStyle [
	self 
		assert: [ aBlStrokeStyle notNil ] 
		description: [ 'Stroke style must be non-nil' ].
	style := aBlStrokeStyle
]

{ #category : #accessing }
BlTextUnderlineAttribute >> width [
	<return: #Number>
	^ width
]

{ #category : #accessing }
BlTextUnderlineAttribute >> width: aNumber [
	self 
		assert: [ aNumber notNil ] 
		description: [ 'Width must be non-nil' ].
	self 
		assert: [ aNumber >= 0 ] 
		description: [ 'Width must be a pozitive number' ].
	width := aNumber
]
