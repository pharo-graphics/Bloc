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
BlLayoutNodeElementMeasurement >> element: aBlElement [

	element := aBlElement
]

{ #category : #measure }
BlLayoutNodeElementMeasurement >> measure: aLayoutChildNode with: anExtentSpecOrBlock [

	^ BlLayoutNodeComputedMeasurement
		position: aLayoutChildNode constraints position
		extent: (self element measure: anExtentSpecOrBlock value)

]
