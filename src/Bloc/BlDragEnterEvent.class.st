Class {
	#name : 'BlDragEnterEvent',
	#superclass : 'BlBaseDragEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragEnterEvent >> sendTo: anObject [
	anObject dragEnterEvent: self
]
