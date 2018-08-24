Class {
	#name : #BlSpaceFocusInEvent,
	#superclass : #BlSpaceEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlSpaceFocusInEvent >> sendTo: anObject [
	anObject spaceFocusInEvent: self
]
