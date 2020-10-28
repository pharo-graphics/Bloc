"
I am a circlular arrow head.
My border width depends on the width of a curve and hence can not be manually specified.

I support background and border paints.
 - For hollow arrowhead let background be transparent.
 - For solid arrowhead make background paint be the same as border paint.
 	(it is possible to specify different paints for border and background)
"
Class {
	#name : #BlArrowheadCircle,
	#superclass : #BlArrowheadElement,
	#instVars : [
		'scale'
	],
	#category : #'Bloc-Geometry-Arrowheads'
}

{ #category : #initialization }
BlArrowheadCircle >> defaultGeometry [
	^ BlEllipseGeometry new
]

{ #category : #initialization }
BlArrowheadCircle >> initialize [
	super initialize.
	
	scale := 3.0
]

{ #category : #changes }
BlArrowheadCircle >> onWidthChanged: aNumber [

	self size: aNumber * self scale asPoint.
	self border: (self border copyWithWidth: aNumber)
]

{ #category : #accessing }
BlArrowheadCircle >> scale [
	<return: #Number>

	^ scale
]

{ #category : #accessing }
BlArrowheadCircle >> scale: aNumber [
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Scale must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Scale must not be negative' ].
	
	scale := aNumber.
	self geometryChanged
]
