Class {
	#name : #BlKeyDownEvent,
	#superclass : #BlKeyboardEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlKeyDownEvent >> sendTo: anObject [
	anObject keyDownEvent: self
]
