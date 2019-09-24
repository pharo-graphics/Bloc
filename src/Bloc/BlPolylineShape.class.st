Class {
	#name : #BlPolylineShape,
	#superclass : #BlCompositeShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #accessing }
BlPolylineShape >> segmentAt: aNumber [
	^ self shapes at: aNumber
]
