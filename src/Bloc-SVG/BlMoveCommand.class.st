Class {
	#name : #BlMoveCommand,
	#superclass : #BlCanvasPathCommand,
	#instVars : [
		'to'
	],
	#category : #'Bloc-SVG-Geometry'
}

{ #category : #'instance creation' }
BlMoveCommand class >> to: aPoint [ 
	
	^ self basicNew
		initializeTo: aPoint;
		yourself
]

{ #category : #initialization }
BlMoveCommand >> initializeTo: aPoint [
	
	self initialize.
	
	to := aPoint
]
