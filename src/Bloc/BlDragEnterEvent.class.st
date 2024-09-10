"
The `BlDragEnterEvent` event is fired when a pointing device enter a drop area
"
Class {
	#name : #BlDragEnterEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDragEnterEvent >> sendTo: anObject [
	anObject dragEnterEvent: self
]
