"
I represent a radial gradient.

The inner and outer center are instances of `Point`.
The inner and outer radius are numbers.
The stops is a collection of associations where keys are numbers between 0.0 and 1.0, and values are instances of `Color`.
"
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

{ #category : #comparing }
BlRadialGradientPaint >> = aBlPaint [

	super = aBlPaint ifFalse: [ ^ false ].
	^ self innerCenter = aBlPaint innerCenter and: [
		  self innerRadius = aBlPaint innerRadius and: [
			  self outerCenter = aBlPaint outerCenter and: [
				  self outerRadius = aBlPaint outerRadius ] ] ]
]

{ #category : #accessing }
BlRadialGradientPaint >> center: aPoint [
	"Set the innerCenter and outerCenter at the specified Point."

	innerCenter := outerCenter := aPoint
]

{ #category : #comparing }
BlRadialGradientPaint >> hash [

	^ super hash bitXor:
		(innerCenter hash bitXor:
		   (outerCenter hash bitXor:
				(innerRadius bitXor: outerRadius)))
]

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
BlRadialGradientPaint >> innerRadius: aNumber [

	innerRadius := aNumber
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

{ #category : #accessing }
BlRadialGradientPaint >> radius: aNumber [
	"Set the outerRadius. The innerRadius will be set to zero."

	innerRadius := 0.0.
	outerRadius := aNumber
]
