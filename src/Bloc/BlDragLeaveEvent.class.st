Class {
	#name : #BlDragLeaveEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDragLeaveEvent >> sendTo: anObject [
	anObject dragLeaveEvent: self
]
