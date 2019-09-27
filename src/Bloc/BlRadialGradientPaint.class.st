Class {
	#name : #BlRadialGradientPaint,
	#superclass : #BlGradientPaint,
	#instVars : [
		'center',
		'radius',
		'focalPoint'
	],
	#category : #'Bloc-Paint'
}

{ #category : #accessing }
BlRadialGradientPaint >> center [
	^ center
]

{ #category : #accessing }
BlRadialGradientPaint >> center: anObject [
	center := anObject
]

{ #category : #accessing }
BlRadialGradientPaint >> focalPoint [
	^focalPoint ifNil:[focalPoint := center]
]

{ #category : #accessing }
BlRadialGradientPaint >> focalPoint: aPoint [
	focalPoint := aPoint
]

{ #category : #geometry }
BlRadialGradientPaint >> matchExtent: anExtent [
	
	self center: anExtent * (self center / 100.0) asFloatPoint.
	self focalPoint: anExtent * (self focalPoint / 100.0) asFloatPoint.
	self radius: (anExtent distanceTo: 0@0) * (self radius / 100.0) asFloat
]

{ #category : #accessing }
BlRadialGradientPaint >> radius [
	^ radius
]

{ #category : #accessing }
BlRadialGradientPaint >> radius: anObject [
	radius := anObject
]
