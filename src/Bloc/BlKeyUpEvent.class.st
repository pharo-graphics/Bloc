Class {
	#name : 'BlKeyUpEvent',
	#superclass : 'BlKeyboardEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlKeyUpEvent >> sendTo: anObject [
	anObject keyUpEvent: self
]
