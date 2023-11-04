Class {
	#name : 'BlDragLeaveEvent',
	#superclass : 'BlBaseDragEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDragLeaveEvent >> sendTo: anObject [
	anObject dragLeaveEvent: self
]
