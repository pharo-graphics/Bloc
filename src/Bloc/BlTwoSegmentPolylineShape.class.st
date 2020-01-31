Class {
	#name : #BlTwoSegmentPolylineShape,
	#superclass : #BlPolylineShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'instance creation' }
BlTwoSegmentPolylineShape class >> left: aLeftLine right: aRight [
]

{ #category : #accessing }
BlTwoSegmentPolylineShape >> connection [
	^ self left toPoint
]

{ #category : #accessing }
BlTwoSegmentPolylineShape >> left [
	^ self segmentAt: 1
]

{ #category : #accessing }
BlTwoSegmentPolylineShape >> right [
	^ self segmentAt: 2
]
