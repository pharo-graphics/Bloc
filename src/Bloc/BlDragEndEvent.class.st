Class {
	#name : 'BlDragEndEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlDragEndEvent >> sendTo: anObject [
	anObject dragEndEvent: self
]
