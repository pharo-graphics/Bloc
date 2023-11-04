Class {
	#name : 'BlLayoutNodeComputedMeasurement',
	#superclass : 'BlLayoutNodeMeasurement',
	#instVars : [
		'position',
		'extent'
	],
	#package : 'Bloc',
	#tag : 'Layouts-Model'
}

{ #category : 'accessing' }
BlLayoutNodeComputedMeasurement >> extent [
	^ extent
]

{ #category : 'accessing' }
BlLayoutNodeComputedMeasurement >> extent: anObject [
	extent := anObject
]

{ #category : 'initialization' }
BlLayoutNodeComputedMeasurement >> initialize [
	super initialize.
	
	position := 0.0@0.0
]

{ #category : 'measure' }
BlLayoutNodeComputedMeasurement >> measure: aLayoutChildNode with: anExtentSpecOrBlock [
	<return: #BlLayoutNodeMeasurement>
	
	^ self
]

{ #category : 'accessing' }
BlLayoutNodeComputedMeasurement >> position [
	^ position
]

{ #category : 'accessing' }
BlLayoutNodeComputedMeasurement >> position: aPoint [
	position := aPoint
]
