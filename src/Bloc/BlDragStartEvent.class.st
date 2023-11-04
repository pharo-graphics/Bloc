Class {
	#name : #BlDragStartEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlDragStartEvent >> sendTo: anObject [
	anObject dragStartEvent: self
]
