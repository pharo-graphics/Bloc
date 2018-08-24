Class {
	#name : #BlDragLeaveEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlDragLeaveEvent >> sendTo: anObject [
	anObject dragLeaveEvent: self
]
