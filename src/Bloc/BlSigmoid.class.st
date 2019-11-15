Class {
	#name : #BlSigmoid,
	#superclass : #BlGeometry,
	#instVars : [
		'from',
		'to',
		'sharpness',
		'bendingPoint',
		'fromControl',
		'toControl'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlSigmoid >> bendingPoint: aFloatNumber [
	"aFloatNumber must be within interval [0...1]"
	| aNewBendingPoint |
	
	aNewBendingPoint := aFloatNumber min: 1 max: 0.
	(bendingPoint closeTo: aNewBendingPoint)
		ifTrue: [ ^ self ].
		
	bendingPoint := aNewBendingPoint.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoid >> computeFromControlPoint [
	"I compute the location of the from control point related to the start of the sigmoid based
	on sharpness and bending point"
	<return: #Point>
	| anAbsoluteVector aDistanceBetweenPoints isHorizontal aDistanceToControlPoint |
	
	anAbsoluteVector := (to - from) abs.
	aDistanceBetweenPoints := anAbsoluteVector max.
	
	"the horizontal distance between points is more than  vertical"
	isHorizontal := anAbsoluteVector x >= anAbsoluteVector y.
	
	"when bending point is 0.5 it means that both control points have the same distance from the start and end.
	if bending point is for example than 0.25 then the distance to `from control point` should twice as small as
	to `to control point`"
	aDistanceToControlPoint := bendingPoint <= 0.5
		ifTrue: [ sharpness * aDistanceBetweenPoints * (bendingPoint / 0.5) ]
		ifFalse: [ sharpness * aDistanceBetweenPoints ].
	
	"from control point should be shifted by aDistanceToControlPoint in the direction of the curve"
	^ isHorizontal
		ifTrue: [ (((to - from) x sign * aDistanceToControlPoint) @ 0) + from ]
		ifFalse: [ (0 @ ((to - from) y sign * aDistanceToControlPoint)) + from ]
]

{ #category : #private }
BlSigmoid >> computeToControlPoint [
	"I compute the location of the to control point related to the start of the sigmoid based
	on sharpness and bending point"
	<return: #Point>
	| anAbsoluteVector aDistanceBetweenPoints isHorizontal aDistanceToControlPoint |
	
	anAbsoluteVector := (to - from) abs.
	aDistanceBetweenPoints := anAbsoluteVector max.
	
	"the horizontal distance between points is more than  vertical"
	isHorizontal := anAbsoluteVector x >= anAbsoluteVector y.
	
	"when bending point is 0.5 it means that both control points have the same distance from the start and end.
	if bending point is for example than 0.75 then the distance to `to control point` should twice as small as
	to `from control point`"
	aDistanceToControlPoint := bendingPoint > 0.5
		ifTrue: [ sharpness * aDistanceBetweenPoints * ((1 - bendingPoint) / 0.5) ]
		ifFalse: [ sharpness * aDistanceBetweenPoints ].
	
	"to control point should be shifted by aDistanceToControlPoint in the opposite direction of the curve"
	^ isHorizontal
		ifTrue: [ (((from - to) x sign * aDistanceToControlPoint) @ 0) + to ]
		ifFalse: [ (0 @ ((from - to) y sign * aDistanceToControlPoint)) + to ]
]

{ #category : #'instance creation' }
BlSigmoid >> from: aFromPoint to: aToPoint [

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint.

	self updateControlPoints
]

{ #category : #initialization }
BlSigmoid >> initialize [
	super initialize.
	
	from := 0 asPoint.
	to := 0 asPoint.
	fromControl := 0 asPoint.
	toControl := 0 asPoint.
	bendingPoint := 0.5.
	sharpness := 0.5
]

{ #category : #geometry }
BlSigmoid >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #accessing }
BlSigmoid >> sharpness: aFloatNumber [
	"aFloatNumber must be within interval [0...1]"
	| aNewSharpness |
	
	aNewSharpness := aFloatNumber min: 1 max: 0.
	(sharpness closeTo: aNewSharpness)
		ifTrue: [ ^ self ].
		
	sharpness := aNewSharpness.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoid >> updateControlPoints [
	fromControl := self computeFromControlPoint.
	toControl := self computeToControlPoint.
]
