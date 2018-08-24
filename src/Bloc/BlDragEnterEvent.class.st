Class {
	#name : #BlDragEnterEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlDragEnterEvent >> sendTo: anObject [
	anObject dragEnterEvent: self
]
