Class {
	#name : #BlSigmoid,
	#superclass : #BlGeometry,
	#instVars : [
		'from',
		'to',
		'isHorizontal',
		'sharpness',
		'bendingPoint',
		'fromControl',
		'toControl'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlSigmoid >> bendingPoint: aFloatNumber [
	(bendingPoint closeTo: aFloatNumber)
		ifTrue: [ ^ self ].
		
	bendingPoint := aFloatNumber.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoid >> computeFromControlPoint [
	"I compute the location of the control point related to the start of the sigmoid based
	on sharpness and bending point"
]

{ #category : #private }
BlSigmoid >> computeToControlPoint [
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
	
	from := 0.
	to := 0.
	fromControl := 0.
	toControl := 0.
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
	(sharpness closeTo: aFloatNumber)
		ifTrue: [ ^ self ].
		
	sharpness := aFloatNumber.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoid >> updateControlPoints [
	fromControl := self computeFromControlPoint.
	toControl := self computeToControlPoint.
]
