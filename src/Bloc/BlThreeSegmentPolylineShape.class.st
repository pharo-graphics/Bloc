Class {
	#name : #BlThreeSegmentPolylineShape,
	#superclass : #BlPolylineShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #accessing }
BlThreeSegmentPolylineShape >> middle [
	^ self segmentAt: 2
]
