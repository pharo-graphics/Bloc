Class {
	#name : #BlTwoSegmentPolylineShape,
	#superclass : #BlPolylineShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'instance creation' }
BlTwoSegmentPolylineShape class >> left: aLeftLine right: aRight [
]

{ #category : #accessors }
BlTwoSegmentPolylineShape >> connection [
	^ self left toPoint
]

{ #category : #accessors }
BlTwoSegmentPolylineShape >> left [
	^ self segmentAt: 1
]

{ #category : #accessors }
BlTwoSegmentPolylineShape >> right [
	^ self segmentAt: 2
]
