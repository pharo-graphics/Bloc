Class {
	#name : #BlSigmoidGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to',
		'sharpness',
		'bendingPoint',
		'fromControl',
		'toControl',
		'orientation'
	],
	#classVars : [
		'AutomaticOrientation',
		'HorizontalOrientation',
		'VerticalOrientation'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'class initialization' }
BlSigmoidGeometry class >> initialize [
	AutomaticOrientation := #automatic.
	VerticalOrientation := #vertical.
	HorizontalOrientation := #horizontal
]

{ #category : #accessing }
BlSigmoidGeometry >> beAutomatic [
	self orientation: AutomaticOrientation
]

{ #category : #accessing }
BlSigmoidGeometry >> beHorizontal [
	self orientation: HorizontalOrientation
]

{ #category : #accessing }
BlSigmoidGeometry >> beVertical [
	self orientation: VerticalOrientation
]

{ #category : #accessing }
BlSigmoidGeometry >> bendingPoint: aFloatNumber [
	"aFloatNumber must be within interval [0...1]"

	| aNewBendingPoint |
	aNewBendingPoint := aFloatNumber min: 1.0 max: 0.0.
	(bendingPoint closeTo: aNewBendingPoint) ifTrue: [ ^ self ].

	bendingPoint := aNewBendingPoint.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoidGeometry >> computeFromControlPoint [
	"I compute the location of the from control point related to the start of the sigmoid based
	on sharpness and bending point"
	<return: #Point>
	| anAbsoluteVector aDistanceBetweenPoints isHorizontal aDistanceToControlPoint |
	
	anAbsoluteVector := (to - from) abs.
	aDistanceBetweenPoints := anAbsoluteVector max.
	
	isHorizontal := self isHorizontal
		ifTrue: [ true ]
		ifFalse: [ self isVertical
			ifTrue: [ false ]
			"the horizontal distance between points is more than vertical"
			ifFalse: [ anAbsoluteVector x >= anAbsoluteVector y ] ].
	
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
BlSigmoidGeometry >> computeToControlPoint [
	"I compute the location of the to control point related to the start of the sigmoid based
	on sharpness and bending point"
	<return: #Point>
	| anAbsoluteVector aDistanceBetweenPoints isHorizontal aDistanceToControlPoint |
	
	anAbsoluteVector := (to - from) abs.
	aDistanceBetweenPoints := anAbsoluteVector max.
	
	isHorizontal := self isHorizontal
		ifTrue: [ true ]
		ifFalse: [ self isVertical
			ifTrue: [ false ]
			"the horizontal distance between points is more than vertical"
			ifFalse: [ anAbsoluteVector x >= anAbsoluteVector y ] ].
	
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
BlSigmoidGeometry >> from: aFromPoint to: aToPoint [

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint.

	self updateControlPoints
]

{ #category : #initialization }
BlSigmoidGeometry >> initialize [
	super initialize.
	
	from := 0 asPoint.
	to := 0 asPoint.
	fromControl := 0 asPoint.
	toControl := 0 asPoint.
	bendingPoint := 0.5.
	sharpness := 0.5.
	orientation := AutomaticOrientation
]

{ #category : #private }
BlSigmoidGeometry >> isAutomatic [
	^ orientation = AutomaticOrientation
]

{ #category : #private }
BlSigmoidGeometry >> isHorizontal [
	^ orientation = HorizontalOrientation
]

{ #category : #private }
BlSigmoidGeometry >> isVertical [
	^ orientation = VerticalOrientation
]

{ #category : #geometry }
BlSigmoidGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #private }
BlSigmoidGeometry >> orientation: anOrientation [
	orientation = anOrientation
		ifTrue: [ ^ self ].
	orientation := anOrientation.
	
	self updateControlPoints.
	self releaseCache
]

{ #category : #accessing }
BlSigmoidGeometry >> sharpness: aFloatNumber [
	"aFloatNumber must be within interval [0...1]"

	| aNewSharpness |
	aNewSharpness := aFloatNumber min: 1.0 max: 0.0.
	(sharpness closeTo: aNewSharpness) ifTrue: [ ^ self ].

	sharpness := aNewSharpness.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoidGeometry >> updateControlPoints [
	fromControl := self computeFromControlPoint.
	toControl := self computeToControlPoint.
]
