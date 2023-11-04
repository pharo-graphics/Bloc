Class {
	#name : 'BlKeyDownEvent',
	#superclass : 'BlKeyboardEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlKeyDownEvent >> sendTo: anObject [
	anObject keyDownEvent: self
]
