Class {
	#name : #BlLineCommand,
	#superclass : #BlCanvasPathCommand,
	#instVars : [
		'to'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlLineCommand class >> to: aPoint [ 
	
	^ self basicNew
		initializeTo: aPoint;
		yourself
]

{ #category : #initialization }
BlLineCommand >> initializeTo: aPoint [
	
	self initialize.
	
	to := aPoint
]
