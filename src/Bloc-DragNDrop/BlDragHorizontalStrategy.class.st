Class {
	#name : #BlDragHorizontalStrategy,
	#superclass : #BlDragDefaultStrategy,
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #'as yet unclassified' }
BlDragHorizontalStrategy >> drag: aDraggedContainer to: aPoint withOffset: offset [

	aDraggedContainer position:
		 (aPoint - offset) x @ aDraggedContainer measuredBounds position y
]

{ #category : #'as yet unclassified' }
BlDragHorizontalStrategy >> drop: aPreviewElement at: aPoint [

	aPreviewElement position: aPoint x @ aPreviewElement measuredBounds position y
]
