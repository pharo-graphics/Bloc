Class {
	#name : #BlPolylineShape,
	#superclass : #BlCurveShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #accessing }
BlPolylineShape >> segmentAt: aNumber [
	^ self shapes at: aNumber
]
