Class {
	#name : #BlKeyUpEvent,
	#superclass : #BlKeyboardEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlKeyUpEvent >> sendTo: anObject [
	anObject keyUpEvent: self
]
