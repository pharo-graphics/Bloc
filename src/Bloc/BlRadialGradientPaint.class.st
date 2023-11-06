Class {
	#name : #BlRadialGradientPaint,
	#superclass : #BlGradientPaint,
	#instVars : [
		'innerCenter',
		'innerRadius',
		'outerCenter',
		'outerRadius'
	],
	#category : #'Bloc-Paint'
}

{ #category : #accessing }
BlRadialGradientPaint >> innerCenter [

	^ innerCenter
]

{ #category : #accessing }
BlRadialGradientPaint >> innerCenter: aPoint [

	innerCenter := aPoint
]

{ #category : #accessing }
BlRadialGradientPaint >> innerRadius [

	^ innerRadius
]

{ #category : #accessing }
BlRadialGradientPaint >> innerRadius: anObject [

	innerRadius := anObject
]

{ #category : #geometry }
BlRadialGradientPaint >> matchExtent: anExtent [
]

{ #category : #accessing }
BlRadialGradientPaint >> outerCenter [

	^ outerCenter
]

{ #category : #accessing }
BlRadialGradientPaint >> outerCenter: aPoint [

	outerCenter := aPoint
]

{ #category : #accessing }
BlRadialGradientPaint >> outerRadius [

	^ outerRadius
]

{ #category : #accessing }
BlRadialGradientPaint >> outerRadius: aNumber [

	outerRadius := aNumber
]
