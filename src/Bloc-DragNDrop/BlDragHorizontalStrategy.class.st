Class {
	#name : #BlDragHorizontalStrategy,
	#superclass : #BlDragDefaultStrategy,
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #'drag and drop' }
BlDragHorizontalStrategy >> drag: aDraggedContainer to: aPoint withOffset: offset [

	aDraggedContainer position:
		 (aPoint - offset) x @ aDraggedContainer measuredBounds position y
]

{ #category : #'drag and drop' }
BlDragHorizontalStrategy >> drop: aPreviewElement at: aPoint [

	aPreviewElement position: aPoint x @ aPreviewElement measuredBounds position y
]
