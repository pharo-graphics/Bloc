Class {
	#name : 'BlFocusOutEvent',
	#superclass : 'BlBaseFocusEvent',
	#category : 'Bloc-Events'
}

{ #category : 'testing' }
BlFocusOutEvent >> isFocusOut [
	^ true
]

{ #category : 'sending' }
BlFocusOutEvent >> sendTo: anObject [
	anObject focusOutEvent: self
]
