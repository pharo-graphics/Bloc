Class {
	#name : #BlCubicBezierCommand,
	#superclass : #BlCanvasPathCommand,
	#instVars : [
		'from',
		'controlPoint',
		'to'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlCubicBezierCommand class >> from: aPoint controlPoint: aPoint2 to: aPoint3 [

	^ self basicNew
		initializeFrom: aPoint controlPoint: aPoint2 to: aPoint3;
		yourself
]

{ #category : #'instance creation' }
BlCubicBezierCommand >> initializeFrom: aPoint controlPoint: aPoint2 to: aPoint3 [

	self initialize.

	from := aPoint.
	controlPoint := aPoint2.
	to := aPoint3
]
