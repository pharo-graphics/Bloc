Class {
	#name : #BlRadialGradientPaint,
	#superclass : #BlGradientPaint,
	#instVars : [
		'center',
		'radius'
	],
	#category : 'Bloc-Paint'
}

{ #category : 'accessing' }
BlRadialGradientPaint >> center [
	^ center
]

{ #category : 'accessing' }
BlRadialGradientPaint >> center: aPoint [
	center := aPoint
]

{ #category : 'geometry' }
BlRadialGradientPaint >> matchExtent: anExtent [
]

{ #category : 'accessing' }
BlRadialGradientPaint >> radius [
	^ radius
]

{ #category : 'accessing' }
BlRadialGradientPaint >> radius: aNumber [
	radius := aNumber
]
