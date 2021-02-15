"
I represent the border of a BlElement.

Example:

BlBorder builder
	paint: Color red;
	width: 10;
	build
"
Class {
	#name : #BlBorder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'paint',
		'width',
		'style',
		'opacity'
	],
	#classInstVars : [
		'empty'
	],
	#category : #'Bloc-Basic-Border'
}

{ #category : #'instance creation' }
BlBorder class >> builder [
	^ BlBorderBuilder new
]

{ #category : #cleanup }
BlBorder class >> cleanUp [
	super cleanUp.
	
	empty := nil
]

{ #category : #accessing }
BlBorder class >> empty [
	^ empty ifNil: [ empty := self paint: BlPaint transparent width: 0 ]
]

{ #category : #'instance creation' }
BlBorder class >> new [
	self error: 'Use one of the builder methods'
]

{ #category : #'instance creation' }
BlBorder class >> paint: aPaint [

	^ self builder
		paint: aPaint;
		build
]

{ #category : #'instance creation' }
BlBorder class >> paint: aPaint width: aNumber [

	^ self builder
		paint: aPaint;
		width: aNumber;
		build
]

{ #category : #comparing }
BlBorder >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ opacity = anObject opacity
		and: [ paint = anObject paint
				and: [ style = anObject style and: [ width = anObject width ] ] ]
]

{ #category : #copy }
BlBorder >> copyWithOpacity: aNumber [

	^ self class basicNew
		initialize;
		paint: paint;
		style: style;
		width: width;
		opacity: aNumber;
		yourself
]

{ #category : #copy }
BlBorder >> copyWithPaint: aPaint [


	^ self class basicNew
		initialize;
		paint: aPaint;
		style: style;
		width: width;
		opacity: opacity;
		yourself
]

{ #category : #copy }
BlBorder >> copyWithStyle: aStrokeStyle [

	^ self class basicNew
		initialize;
		paint: paint;
		style: aStrokeStyle;
		width: width;
		opacity: opacity;
		yourself
]

{ #category : #copy }
BlBorder >> copyWithWidth: aWidth [

	^ self class basicNew
		initialize;
		paint: paint;
		style: style;
		width: aWidth;
		opacity: opacity;
		yourself
]

{ #category : #comparing }
BlBorder >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ opacity hash
		bitXor: (paint hash bitXor: (style hash bitXor: width hash))
]

{ #category : #testing }
BlBorder >> isTransparent [
	"Return true if I am is transparent and should not be rendered,
	false otherwise"
	<return: #Boolean>

	^ width isZero
]

{ #category : #testing }
BlBorder >> isVisible [
	"Return true if I am visible and should be rendered, false otherwise.
	Note: Non-zero border with transparent paint is still needs to be rendered,
	since it removes an overlapping background area"
	<return: #Boolean>

	^ width isZero not
]

{ #category : #accessing }
BlBorder >> opacity [
	<return: #Number>

	^ opacity
]

{ #category : #accessing }
BlBorder >> opacity: aNumber [

	self
		assert: [ aNumber between: 0.0 and: 1.0 ]
		description: [ 'Opacity value must be within interval [0..1]' ].

	opacity isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	opacity := aNumber
]

{ #category : #accessing }
BlBorder >> paint [
	<return: #BlPaint>

	^ paint
]

{ #category : #accessing }
BlBorder >> paint: aBlPaint [

	paint isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	paint := aBlPaint asBlPaint
]

{ #category : #printing }
BlBorder >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' width: ';
		print: width.
	aStream
		nextPutAll: ' paint: ';
		print: paint
]

{ #category : #accessing }
BlBorder >> style [
	<return: #BlStrokeStyle>

	^ style
]

{ #category : #accessing }
BlBorder >> style: aBlStrokeStyle [

	style isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	style := aBlStrokeStyle
]

{ #category : #accessing }
BlBorder >> width [
	<return: #Number>

	^ width
]

{ #category : #accessing }
BlBorder >> width: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Width must not be negative' ].

	width isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
	
	width := aNumber
]
