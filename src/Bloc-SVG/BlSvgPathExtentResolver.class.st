"
I am used to calculate the extent of a BlSvgPath, thanks to my method 'computeExtentFor:'.

Here is how I proceed:
	- I take as an input for 'computeExtentFor:' a collection of commands, which is the 'pathData' instance variable of the BlSvgPath.
	- For each of these commands, I perform a method with the same name. These method take the extreme points of the segment drawn by the command and then checks if these points should alter my instance variables 'minPoint' and/or 'maxPoint'.
	- Once all the commands have been computed, I return the extent (which is 'maxPoint' minus 'minPoint').

Example of use:
	- BlSvgPathExtentResolver new computeExtentFor: aBlSvgPath pathData
"
Class {
	#name : #BlSvgPathExtentResolver,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'relative',
		'previousPoint',
		'previousControlPoint',
		'maxPoint',
		'minPoint',
		'extent'
	],
	#category : 'Bloc-SVG-Path'
}

{ #category : #'path commands' }
BlSvgPathExtentResolver >> absolute [
	relative := false
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> ccwArcTo: endPt angle: rot [
	self computePoints: {endPt}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> close [
	
]

{ #category : #computing }
BlSvgPathExtentResolver >> computeExtentFor: aCollectionOfCmd [
	aCollectionOfCmd do: [ :cmd | cmd executeOn: self ].
	extent := maxPoint - minPoint.
]

{ #category : #computing }
BlSvgPathExtentResolver >> computePoints: aCollection [
	| currentPoint |
	aCollection do: [ :aPoint | 
			currentPoint := self convertToAbsolutePoint: aPoint.
			minPoint := minPoint min: currentPoint.
			maxPoint := maxPoint max: currentPoint ].
	previousPoint := currentPoint
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> convertToAbsolutePoint: aPoint [
	^ self ifRelative: [ previousPoint + aPoint ] ifAbsolute: [ aPoint ]
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> curveVia: cp1 and: cp2 to: aPoint [
	previousControlPoint := cp2.
	self computePoints: {cp1. cp2. aPoint}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> curveVia: cp1 to: aPoint [
	previousControlPoint := cp1.
	self computePoints: {cp1. aPoint}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> cwArcTo: endPt angle: rot [
	self computePoints: {endPt}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> ellipticalArc: radii xrot: rotation large: largeFlag sweep: sweepFlag to: pt [
	|max min|
	max:= pt + (radii * 2).
	min:= pt - (radii * 2).

	self computePoints: { max. min. pt.}
]

{ #category : #accessing }
BlSvgPathExtentResolver >> extent [
	^ extent
]

{ #category : #'builder commands' }
BlSvgPathExtentResolver >> hLineTo: aNumber [
	self computePoints: {(aNumber @ 0)}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> ifRelative: aRBlock ifAbsolute: aABlock [
	^ self isRelative
		ifTrue: aRBlock
		ifFalse: aABlock
]

{ #category : #initialization }
BlSvgPathExtentResolver >> initialize [
	super initialize.
	relative := false.
	previousPoint := 0@0.
	minPoint := SmallInteger maxVal asPoint.
	maxPoint := SmallInteger minVal asPoint.
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> isRelative [
	^ relative ifNil: [ false ]
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> lineTo: aPoint [
	self computePoints: {aPoint}
]

{ #category : #accessing }
BlSvgPathExtentResolver >> maxPoint [
	^ maxPoint
]

{ #category : #accessing }
BlSvgPathExtentResolver >> minPoint [
	^ minPoint
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> moveTo: aPoint [
	self computePoints: {aPoint}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> reflectedCurveTo: aPoint [
	|collection|
	collection := OrderedCollection new.
	previousControlPoint ifNotNil: [collection add: (previousPoint * 2 - previousControlPoint)].
	collection add: aPoint.
	
	self computePoints: collection
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> reflectedCurveVia: cp2 to: aPoint [
	previousControlPoint := cp2.
	self computePoints: {cp2. aPoint}
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> relative [
	relative := true
]

{ #category : #'path commands' }
BlSvgPathExtentResolver >> string: aString font: aFont [

]

{ #category : #'builder commands' }
BlSvgPathExtentResolver >> vLineTo: aNumber [ 
	self computePoints: { 0@aNumber }
]
