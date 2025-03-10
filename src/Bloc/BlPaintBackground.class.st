"
I am a background that uses a `=BlPaint`=. A paint can be either a simple color or a type of gradient.

## Examples
Examples are provided by the class `BlPaintBackgroundExamples`.


"
Class {
	#name : #BlPaintBackground,
	#superclass : #BlBackground,
	#instVars : [
		'paint'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #'instance creation' }
BlPaintBackground class >> paint: aBlPaint [

	^ self new
		paint: aBlPaint;
		yourself
]

{ #category : #comparing }
BlPaintBackground >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].
	anotherObject opacity = self opacity ifFalse: [ ^ false ].
	^ anotherObject paint = self paint
]

{ #category : #comparing }
BlPaintBackground >> hash [

	^ super hash bitXor: self paint hash
]

{ #category : #testing }
BlPaintBackground >> isOpaque [

	^ (self opacity closeTo: 1) and: [ self paint isOpaque ]
]

{ #category : #testing }
BlPaintBackground >> isPaintBackground [ 

	^ true
]

{ #category : #testing }
BlPaintBackground >> isTransparent [
	"Paint background is transparent then and only then when paint is transparent or opacity is close to 0"

	^ (self opacity closeTo: 0.0) or: [ self paint isTransparent ]
]

{ #category : #geometry }
BlPaintBackground >> matchExtent: anExtent [

	self paint matchExtent: anExtent
]

{ #category : #accessing }
BlPaintBackground >> paint [

	^ paint
]

{ #category : #accessing }
BlPaintBackground >> paint: aBlPaint [

	paint isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	paint := aBlPaint asBlPaint
]
