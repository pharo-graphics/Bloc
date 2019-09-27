Class {
	#name : #BlThreeSegmentPolylineShape,
	#superclass : #BlPolylineShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'as yet unclassified' }
BlThreeSegmentPolylineShape >> middle [
	^ self segmentAt: 2
]
