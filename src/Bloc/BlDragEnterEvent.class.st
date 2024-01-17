Class {
	#name : 'BlDragEnterEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragEnterEvent >> sendTo: anObject [
	anObject dragEnterEvent: self
]
