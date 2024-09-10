"
The `BlDragStartEvent` event is fired when a pointing device is clicked on an element to begin dragging it, in a drag&drop move.
"
Class {
	#name : #BlDragStartEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDragStartEvent >> sendTo: anObject [
	anObject dragStartEvent: self
]
