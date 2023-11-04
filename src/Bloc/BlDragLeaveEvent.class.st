Class {
	#name : 'BlDragLeaveEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragLeaveEvent >> sendTo: anObject [
	anObject dragLeaveEvent: self
]
