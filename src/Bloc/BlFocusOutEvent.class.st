Class {
	#name : 'BlFocusOutEvent',
	#superclass : 'BlBaseFocusEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'testing' }
BlFocusOutEvent >> isFocusOut [
	^ true
]

{ #category : 'sending' }
BlFocusOutEvent >> sendTo: anObject [
	anObject focusOutEvent: self
]
