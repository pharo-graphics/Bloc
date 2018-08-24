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
	#category : 'Bloc-Basic-Visual'
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

{ #category : #copy }
BlBorder >> copyWithPaint: aPaint [

	self
		assert: [ aPaint isNotNil ]
		description: [ 'Paint must not be nil' ].

	^ self class new
		paint: aPaint asBlPaint;
		style: style;
		width: width;
		opacity: opacity;
		yourself
]

{ #category : #copy }
BlBorder >> copyWithStyle: aStrokeStyle [

	self
		assert: [ aStrokeStyle isNotNil ]
		description: [ 'Style must not be nil' ].

	^ self class new
		paint: paint;
		style: aStrokeStyle;
		width: width;
		opacity: opacity;
		yourself
]

{ #category : #copy }
BlBorder >> copyWithWidth: aWidth [

	self
		assert: [ aWidth isNotNil ]
		description: [ 'Width must not be nil' ].

	^ self class new
		paint: paint;
		style: style;
		width: aWidth;
		opacity: opacity;
		yourself
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
	^ opacity
]

{ #category : #accessing }
BlBorder >> opacity: anObject [
	opacity := anObject
]

{ #category : #accessing }
BlBorder >> paint [
	^ paint
]

{ #category : #accessing }
BlBorder >> paint: anObject [
	paint := anObject
]

{ #category : #accessing }
BlBorder >> style [
	^ style
]

{ #category : #accessing }
BlBorder >> style: anObject [
	style := anObject
]

{ #category : #accessing }
BlBorder >> width [
	^ width
]

{ #category : #accessing }
BlBorder >> width: anObject [
	width := anObject
]
