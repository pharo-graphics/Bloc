Class {
	#name : #BlGradientPaint,
	#superclass : #BlPaint,
	#instVars : [
		'stops'
	],
	#category : #'Bloc-Paint'
}

{ #category : #comparing }
BlGradientPaint >> = aBlPaint [

	self == aBlPaint ifTrue: [ ^ true ].
	self class == aBlPaint class ifFalse: [ ^ false ].
	^ self stops = aBlPaint stops
]

{ #category : #initialization }
BlGradientPaint >> from: aStartColor to: anEndColor [
	"A convenience method to create a gradient consisting out of 2 colors"
	
	self stops: { 
		0 -> aStartColor.
		1 -> anEndColor
	}
]

{ #category : #accessing }
BlGradientPaint >> stops [
	^ stops
]

{ #category : #accessing }
BlGradientPaint >> stops: anArray [
	stops := anArray
]
