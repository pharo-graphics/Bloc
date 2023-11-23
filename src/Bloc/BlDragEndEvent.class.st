Class {
	#name : 'BlDragEndEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragEndEvent >> sendTo: anObject [
	anObject dragEndEvent: self
]
