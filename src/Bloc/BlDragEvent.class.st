Class {
	#name : #BlDragEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlDragEvent >> isDrag [
	^ true
]

{ #category : #sending }
BlDragEvent >> sendTo: anObject [
	anObject dragEvent: self
]
