Class {
	#name : 'BlDragEnterEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlDragEnterEvent >> sendTo: anObject [
	anObject dragEnterEvent: self
]
