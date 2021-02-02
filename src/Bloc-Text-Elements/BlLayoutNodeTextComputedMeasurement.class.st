Class {
	#name : #BlLayoutNodeTextComputedMeasurement,
	#superclass : #BlLayoutNodeMeasurement,
	#instVars : [
		'paragraph',
		'extent'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #accessing }
BlLayoutNodeTextComputedMeasurement >> extent [
	^ extent
]

{ #category : #accessing }
BlLayoutNodeTextComputedMeasurement >> extent: anObject [
	extent := anObject
]

{ #category : #measure }
BlLayoutNodeTextComputedMeasurement >> measure: aLayoutChildNode with: anExtentSpecOrBlock [
	<return: #BlLayoutNodeMeasurement>
	
	^ self
]

{ #category : #accessing }
BlLayoutNodeTextComputedMeasurement >> paragraph [
	^ paragraph
]

{ #category : #accessing }
BlLayoutNodeTextComputedMeasurement >> paragraph: anObject [
	paragraph := anObject
]
