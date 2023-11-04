Class {
	#name : 'BlDragEvent',
	#superclass : 'BlBaseDragEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'testing' }
BlDragEvent >> isDrag [
	^ true
]

{ #category : 'sending' }
BlDragEvent >> sendTo: anObject [
	anObject dragEvent: self
]
