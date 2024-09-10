"
The `BlDragEvent` event is fired when a pointing device is moving over a `BlSpace` scene a dragged element
"
Class {
	#name : #BlDragEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlDragEvent >> isDrag [
	^ true
]

{ #category : #sending }
BlDragEvent >> sendTo: anObject [
	anObject dragEvent: self
]
