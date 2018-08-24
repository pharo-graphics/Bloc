Class {
	#name : #BlDragOverEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlDragOverEvent >> sendTo: anObject [
	anObject dragOverEvent: self
]
