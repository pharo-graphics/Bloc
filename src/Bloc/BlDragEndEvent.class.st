Class {
	#name : 'BlDragEndEvent',
	#superclass : 'BlBaseDragEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragEndEvent >> sendTo: anObject [
	anObject dragEndEvent: self
]
