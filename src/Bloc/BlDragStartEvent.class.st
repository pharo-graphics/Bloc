Class {
	#name : 'BlDragStartEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragStartEvent >> sendTo: anObject [
	anObject dragStartEvent: self
]
