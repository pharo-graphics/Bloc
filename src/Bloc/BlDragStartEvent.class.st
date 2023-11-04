Class {
	#name : 'BlDragStartEvent',
	#superclass : 'BlBaseDragEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragStartEvent >> sendTo: anObject [
	anObject dragStartEvent: self
]
