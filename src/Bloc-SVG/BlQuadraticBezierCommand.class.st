Class {
	#name : #BlQuadraticBezierCommand,
	#superclass : #BlCanvasPathCommand,
	#instVars : [
		'from',
		'controlPoint',
		'to'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlQuadraticBezierCommand class >> from: aPoint controlPoint: aPoint2 to: aPoint3 [ 
	
	^ self basicNew
		initializeFrom: aPoint controlPoint: aPoint2 to: aPoint3;
		yourself
]

{ #category : #initialization }
BlQuadraticBezierCommand >> initializeFrom: aPoint controlPoint: aPoint2 to: aPoint3 [

	self initialize.

	from := aPoint.
	controlPoint := aPoint2.
	to := aPoint3
]
