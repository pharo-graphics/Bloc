Class {
	#name : #BlDragVerticalStrategy,
	#superclass : #BlDragDefaultStrategy,
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #'drag and drop' }
BlDragVerticalStrategy >> drag: aDraggedContainer to: aPoint withOffset: offset [

	aDraggedContainer position: 
		aDraggedContainer  measuredBounds position x @ (	aPoint - offset) y
]

{ #category : #'drag and drop' }
BlDragVerticalStrategy >> drop: aPreviewElement at: aPoint [

	aPreviewElement position: aPreviewElement measuredBounds position x @ aPoint y
]
