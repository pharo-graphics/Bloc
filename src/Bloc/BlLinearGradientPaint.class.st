Class {
	#name : #BlLinearGradientPaint,
	#superclass : #BlGradientPaint,
	#instVars : [
		'start',
		'end',
		'scalePoint'
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
	"See: https://stackoverflow.com/questions/38821631/cagradientlayer-diagonal-gradient/43176174"

	| d coef endPoint aspectRatio u center |
	anExtent isZero ifTrue: [ ^ self ].
	
	d := self end - self start.
	d := d isZero
		ifTrue: [ anExtent x @ 0.0 ]
		ifFalse: [ d normalized ].
	aspectRatio := anExtent x / anExtent y.
	u := (d x * aspectRatio) @ (d y / aspectRatio).
	coef := (d dotProduct: u) / (u dotProduct: u).
	endPoint := u * coef.

	center := anExtent / 2.
	self start: center * (1.0 asPoint - endPoint).
	self end: center * (1.0 asPoint + endPoint)
]

{ #category : #accessing }
BlLinearGradientPaint >> start [
	^ start
]

{ #category : #accessing }
BlLinearGradientPaint >> start: aPoint [
	start := aPoint
]
