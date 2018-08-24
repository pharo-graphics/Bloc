"
I am a simple arrow-like arrowhead.
Both my size and arrow length depend on the curve width.

It is possible hovewer to customize a length fraction - how long should be the outer ""arrow"" compared to the length of the side of a nose triangle.

Users can also customise nose angle that tells how wide should the arrow lines be spread.
The with of the outer arrows can be specified by changing border width of a simple arrow arrowhead.

I support both background and border paint and can have hollow inner triangle.
"
Class {
	#name : #BlArrowheadSimpleArrow,
	#superclass : #BlArrowheadElement,
	#instVars : [
		'arrowLengthFraction',
		'arrowNoseAngle'
	],
	#category : 'Bloc-Geometry-Arrowheads'
}

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowLengthFraction [
	<return: #Number>
	
	^ arrowLengthFraction
]

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowLengthFraction: aNumber [
	
	arrowLengthFraction := aNumber.
	self geometryChanged
]

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowNoseAngle [
	<return: #Number>

	^ arrowNoseAngle
]

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowNoseAngle: anAngleInDegrees [

	self
		assert: [ anAngleInDegrees > 0 and: [ anAngleInDegrees < 180 ] ]
		description: [ 'Angle should be within interval [0 ... 180]' ].

	arrowNoseAngle := anAngleInDegrees.
	self geometryChanged
]

{ #category : #geometry }
BlArrowheadSimpleArrow >> computeInnerHeight: aNumber [
	<return: #Number>
	
	^ aNumber
]

{ #category : #geometry }
BlArrowheadSimpleArrow >> computeInnerLength: aNumber [
	<return: #Number>
	"hypotenuse = (Hi / 2) * cos(alpha / 2)"

	^ (self computeInnerHeight: aNumber) / 2.0 / (self arrowNoseAngle degreesToRadians / 2.0) cos
]

{ #category : #geometry }
BlArrowheadSimpleArrow >> computeInnerWidth: aNumber [
	<return: #Number>
	"cathetus = (Hi / 2) * tan(alpha / 2)"

	^ (self computeInnerHeight: aNumber) / 2.0 / (self arrowNoseAngle degreesToRadians / 2.0) tan
]

{ #category : #geometry }
BlArrowheadSimpleArrow >> computeOuterHeight: aNumber [
	<return: #Number>

	^ (self computeOuterLength: aNumber) / (self computeInnerHeight: aNumber) * (self computeInnerHeight: aNumber)
]

{ #category : #geometry }
BlArrowheadSimpleArrow >> computeOuterLength: aNumber [
	<return: #Number>
	| anInnerLength |
	
	anInnerLength := self computeInnerLength: aNumber.
	^ (self arrowLengthFraction * anInnerLength) + anInnerLength
]

{ #category : #geometry }
BlArrowheadSimpleArrow >> computeOuterWidth: aNumber [
	<return: #Number>
	"cathetus = (Hi / 2) * tan(alpha / 2)"

	^ (self computeOuterHeight: aNumber) / 2.0 / (self arrowNoseAngle degreesToRadians / 2.0) tan
]

{ #category : #initialization }
BlArrowheadSimpleArrow >> defaultGeometry [
	^ BlPolygon vertices: {
		0@0.
		60@30.
		0@60.
		40@40.
		40@20
	}
]

{ #category : #initialization }
BlArrowheadSimpleArrow >> initialize [
	super initialize.

	arrowLengthFraction := 3.0.
	arrowNoseAngle := 45
]

{ #category : #changes }
BlArrowheadSimpleArrow >> onWidthChanged: aNumber [
	| aWidth aHeight anOuterWidth anOuterHeight |
	
	aWidth := self computeInnerWidth: aNumber.
	aHeight := self computeInnerHeight: aNumber.

	anOuterWidth := self computeOuterWidth: aNumber.
	anOuterHeight := self computeOuterHeight: aNumber.

	self size: aWidth @ aHeight.
	
	self geometry: (BlPolygon vertices: {
			(aWidth - anOuterWidth) @ ((aHeight - anOuterHeight) / 2.0).
			aWidth @ (aHeight / 2.0).
			(aWidth - anOuterWidth) @ ((aHeight + anOuterHeight) / 2.0).
			0@aHeight.
			0@0.
		})
]
