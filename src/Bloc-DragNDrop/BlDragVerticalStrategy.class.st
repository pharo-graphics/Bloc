Class {
	#name : #BlDragVerticalStrategy,
	#superclass : #BlDragDefaultStrategy,
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #'as yet unclassified' }
BlDragVerticalStrategy >> drag: aDraggedContainer to: aPoint withOffset: offset [

	aDraggedContainer position: 
		aDraggedContainer  measuredBounds position x @ (	aPoint - offset) y
]

{ #category : #'as yet unclassified' }
BlDragVerticalStrategy >> drop: aPreviewElement at: aPoint [

	aPreviewElement position: aPreviewElement measuredBounds position x @ aPoint y
]
