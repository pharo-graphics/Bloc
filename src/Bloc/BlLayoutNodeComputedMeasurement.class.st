Class {
	#name : #BlLayoutNodeComputedMeasurement,
	#superclass : #BlLayoutNodeMeasurement,
	#instVars : [
		'position',
		'extent'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'instance creation' }
BlLayoutNodeComputedMeasurement class >> extent: anExtent [

	^ self position: 0.0 @ 0.0 extent: anExtent
]

{ #category : #'instance creation' }
BlLayoutNodeComputedMeasurement class >> position: aPosition extent: anExtent [

	^ self basicNew
		initializePosition: aPosition extent: anExtent;
		yourself
]

{ #category : #accessing }
BlLayoutNodeComputedMeasurement >> extent [

	^ extent
]

{ #category : #accessing }
BlLayoutNodeComputedMeasurement >> extent: aPoint [

	extent := aPoint
]

{ #category : #initialization }
BlLayoutNodeComputedMeasurement >> initializePosition: aPosition extent: anExtent [

	self initialize.
	
	position := aPosition.
	extent := anExtent
]

{ #category : #measure }
BlLayoutNodeComputedMeasurement >> measure: aLayoutChildNode with: anExtentSpecOrBlock [
	
	^ self
]

{ #category : #accessing }
BlLayoutNodeComputedMeasurement >> position [

	^ position
]

{ #category : #accessing }
BlLayoutNodeComputedMeasurement >> position: aPoint [

	position := aPoint
]
