"
I am a special Paint type background given as a ===BlPaint===.

Example:

	BlPaintBackground paint: Color red
	
	or
	
	BlPaintBackground new
		paint: (BlLinearGradientPaint new
			stops: { 0 -> Color red . 1 -> Color blue};
			start: 0@0;
			end: 100@100);
		yourself
		
Opacity example:

	BlPaintBackground new
		opacity: 0.5;
		paint: (BlRadialGradientPaint new
			stops: { 0 -> Color blue . 1 -> Color red};
			center: 100@100;
			radius: 200);
		yourself
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
BlPaintBackground >> isTransparent [
	"Paint packground is transperent then and only then when paint is transparent"
	<return: #Boolean>

	^ self paint isTransparent
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
	self
		assert: [ aBlPaint isNotNil ]
		description: [ 'Paint must not be nil' ].

	paint isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].

	paint := aBlPaint asBlPaint
]
