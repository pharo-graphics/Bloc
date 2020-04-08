Class {
	#name : #BlThreeSegmentPolylineShape,
	#superclass : #BlPolylineShape,
	#category : #'Bloc-Geometry-Shaper'
}

{ #category : #accessing }
BlThreeSegmentPolylineShape >> middle [
	^ self segmentAt: 2
]
