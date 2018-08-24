Class {
	#name : #BlDropEvent,
	#superclass : #BlBaseDragEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlDropEvent >> sendTo: anObject [
	anObject dropEvent: self
]
