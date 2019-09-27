Class {
	#name : #BlDragOverEvent,
	#superclass : #BlBaseDragEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlDragOverEvent >> sendTo: anObject [
	anObject dragOverEvent: self
]
