Class {
	#name : 'BlKeyDownEvent',
	#superclass : 'BlKeyboardEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlKeyDownEvent >> sendTo: anObject [
	anObject keyDownEvent: self
]
