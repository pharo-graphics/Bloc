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

	| aDirection dx dy width height ux uy coef endPoint center |
	anExtent isZero ifTrue: [ ^ self ].
		
	aDirection := (self end - self start) isZero
		ifTrue: [ 1.0 @ 0.0 ]
		ifFalse: [ (self end - self start) normalized ].

	dx := aDirection x.
	dy := aDirection y.
	width := anExtent x.
	height := anExtent y.
	center := anExtent / 2.

	ux := dx * width / height.
	uy := dy * height / width.
	coef := ((dx * ux) + (dy * uy)) / ((ux * ux) + (uy * uy)).
	endPoint := (coef * ux) @ (coef * uy).

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
