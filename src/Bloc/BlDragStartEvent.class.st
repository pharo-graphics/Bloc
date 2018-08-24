Class {
	#name : #BlDragStartEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlDragStartEvent >> sendTo: anObject [
	anObject dragStartEvent: self
]
