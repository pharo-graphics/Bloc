"
The `BlDragLeaveEvent` event is fired when a pointing device leave a drop area
"
Class {
	#name : #BlDragLeaveEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDragLeaveEvent >> sendTo: anObject [
	anObject dragLeaveEvent: self
]
