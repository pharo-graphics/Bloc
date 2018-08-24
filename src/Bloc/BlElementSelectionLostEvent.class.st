"
Is sent when element is no longer within mouse selection rectangle
"
Class {
	#name : #BlElementSelectionLostEvent,
	#superclass : #BlElementEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlElementSelectionLostEvent >> sendTo: anObject [
	anObject selectionLostEvent: self
]
