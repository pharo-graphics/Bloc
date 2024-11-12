"
This class is part of a new DragHandler prototype
"
Class {
	#name : #BlDragDefaultStrategy,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #accessing }
BlDragDefaultStrategy class >> uniqueInstance [  

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'as yet unclassified' }
BlDragDefaultStrategy >> drag: aDraggedContainer to: aPoint withOffset: offset [ 

	aDraggedContainer position: aPoint - offset 
]

{ #category : #'as yet unclassified' }
BlDragDefaultStrategy >> drop: aPreviewElement at: aPoint [ 

	aPreviewElement position: aPoint
]
