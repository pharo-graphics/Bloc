"
Let's the layout know that the node should be measurement during the first pass of the layout
"
Class {
	#name : #BlLayoutNodeElementMeasurement,
	#superclass : #BlLayoutNodeMeasurement,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutNodeElementMeasurement >> element [
	^ element
]

{ #category : #accessing }
BlLayoutNodeElementMeasurement >> element: anObject [
	element := anObject
]

{ #category : #measure }
BlLayoutNodeElementMeasurement >> measure: aLayoutChildNode with: anExtentSpec [
	<return: #BlLayoutNodeMeasurement>

	^ BlLayoutNodeComputedMeasurement new
		extent: (self element measure: anExtentSpec);
		position: aLayoutChildNode constraints position
]
