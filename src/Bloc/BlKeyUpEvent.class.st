Class {
	#name : 'BlKeyUpEvent',
	#superclass : 'BlKeyboardEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlKeyUpEvent >> sendTo: anObject [
	anObject keyUpEvent: self
]
