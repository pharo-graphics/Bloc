Class {
	#name : #BlLayoutNodeMeasurement,
	#superclass : #Object,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #accessing }
BlLayoutNodeMeasurement >> bounds [
	^ BlBounds origin: self position extent: self extent
]

{ #category : #accessing }
BlLayoutNodeMeasurement >> extent [
	^ 0@0
]

{ #category : #measure }
BlLayoutNodeMeasurement >> measure: aLayoutChildNode with: anExtentSpec [
	<return: #BlLayoutNodeMeasurement>
	
	^ self
]

{ #category : #accessing }
BlLayoutNodeMeasurement >> position [
	^ 0@0
]
