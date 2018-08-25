"
I am a triangular arrow head.
My size depends on the width of a curve and hence can not be manually specified.

It is possible to have a border around triangle by specifying a border width of a triangle arrowhead.

I support background and border paints.
 - For hollow arrowhead let background be transparent.
 - For solid arrowhead make background paint be the same as border paint.
 	(it is possible to specify different paints for border and background)
"
Class {
	#name : #BlArrowheadTriangle,
	#superclass : #BlArrowheadElement,
	#instVars : [
		'scale',
		'borderFraction'
	],
	#category : 'Bloc-Geometry-Arrowheads'
}

{ #category : #accessing }
BlArrowheadTriangle >> borderFraction [
	<return: #Number>

	^ borderFraction
]

{ #category : #accessing }
BlArrowheadTriangle >> borderFraction: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Border fraction must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Bordern fraction must not be negative' ].

	borderFraction := aNumber.
	self geometryChanged
]

{ #category : #initialization }
BlArrowheadTriangle >> defaultGeometry [
	^ BlPolygon vertices: {
		0@0.
		30@30.
		0@60
	}
]

{ #category : #initialization }
BlArrowheadTriangle >> initialize [
	super initialize.
	
	scale := 1.
	borderFraction := 1.0
]

{ #category : #changes }
BlArrowheadTriangle >> onWidthChanged: aNumber [
	| aScaledWidth |
	
	aScaledWidth := self scale * aNumber.

	self size: aScaledWidth asPoint * 2.
	self border: (self border copyWithWidth: (aNumber * self borderFraction) asFloat).

	self geometry: (BlPolygon vertices: {
		0@0.
		(aScaledWidth * 2) @aScaledWidth.
		0@(aScaledWidth * 2)
	})
]

{ #category : #accessing }
BlArrowheadTriangle >> scale [
	<return: #Number>

	^ scale
]

{ #category : #accessing }
BlArrowheadTriangle >> scale: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Scale must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Scale must not be negative' ].
	
	scale := aNumber.
	self geometryChanged
]
