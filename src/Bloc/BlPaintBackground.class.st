"
I am a background that uses a `=BlPaint`=. A paint can be either a simple color or a type of gradient.

## Examples
Examples are provided by the class {{gtClass:BlPaintBackgroundExamples}}.


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
	^ self new paint: aBlPaint
]

{ #category : #comparing }
BlPaintBackground >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject paint = self paint
]

{ #category : #comparing }
BlPaintBackground >> hash [
	^ self paint hash bitXor: self class hash
]

{ #category : #testing }
BlPaintBackground >> isOpaque [
	<return: #Boolean>

	^ (self opacity closeTo: 1) and: [ self paint isOpaque ]
]

{ #category : #testing }
BlPaintBackground >> isTransparent [
	"Paint background is transparent then and only then when paint is transparent or opacity is close to 0"
	<return: #Boolean>

	^ (self opacity closeTo: 0) or: [ self paint isTransparent ]
]

{ #category : #geometry }
BlPaintBackground >> matchExtent: anExtent [
	self paint matchExtent: anExtent
]

{ #category : #accessing }
BlPaintBackground >> paint [
	<return: #BlPaint>

	^ paint
]

{ #category : #accessing }
BlPaintBackground >> paint: aBlPaint [

	paint isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	paint := aBlPaint asBlPaint
]
