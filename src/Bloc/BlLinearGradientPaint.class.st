Class {
	#name : #BlLinearGradientPaint,
	#superclass : #BlGradientPaint,
	#instVars : [
		'start',
		'end'
	],
	#category : #'Bloc-Paint'
}

{ #category : #'instance creation' }
BlLinearGradientPaint class >> direction: aPoint [
	"Create a linear gradient in a given direction"

	| aDirection aStart anEnd aDelta |
	
	aDirection := aPoint asPoint.
	aDirection := aDirection isZero
		ifTrue: [ 1@0 ]
		ifFalse: [ aDirection normalized].

	aStart := 0 asPoint.
	anEnd := aStart + aDirection.	
	aDelta := aStart min: anEnd.

	^ self new
		start: aStart - aDelta;
		end: anEnd - aDelta;
		matchExtent: 1.0 asPoint;
		yourself
]

{ #category : #'instance creation' }
BlLinearGradientPaint class >> horizontal [
	"Create a horizontal linear gradient"

	^ self new
		start: 0@0;
		end: 1@0;
		yourself
]

{ #category : #'instance creation' }
BlLinearGradientPaint class >> vertical [
	"Create a vertical linear gradient"

	^ self new
		start: 0@0;
		end: 0@1;
		yourself
]

{ #category : #comparing }
BlLinearGradientPaint >> = aBlPaint [

	super = aBlPaint ifFalse: [ ^ false ].
	^ self end = aBlPaint end and: [ self start = aBlPaint start ]
]

{ #category : #accessing }
BlLinearGradientPaint >> end [
	^ end
]

{ #category : #accessing }
BlLinearGradientPaint >> end: aPoint [
	end := aPoint
]

{ #category : #geometry }
BlLinearGradientPaint >> matchExtent: anExtent [
	| aDirection aStart anEnd aDelta aScaleX aScaleY |
	
	anExtent isZero
		ifTrue: [ ^ self ].
		
	aDirection :=  (self end - self start) isZero
		ifTrue: [ 1@0 ]
		ifFalse: [ (self end - self start) normalized ].

	aStart := 0@0.
	anEnd := aStart + (anExtent * aDirection).
	
	aScaleX := (anEnd x isZero
		ifTrue: [ 1.0 ]
		ifFalse: [ anExtent x / anEnd x ]) abs.
	aScaleY := (anEnd y isZero
		ifTrue: [ 1.0 ]
		ifFalse: [ anExtent y / anEnd y ]) abs.
	anEnd := anEnd * (aScaleX @ aScaleY).
	
	aDelta := anEnd min: aStart.

	self start: aStart - aDelta.
	self end: anEnd - aDelta
]

{ #category : #accessing }
BlLinearGradientPaint >> start [
	^ start
]

{ #category : #accessing }
BlLinearGradientPaint >> start: aPoint [
	start := aPoint
]
