Class {
	#name : #BlDragEndEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlDragEndEvent >> sendTo: anObject [
	anObject dragEndEvent: self
]
