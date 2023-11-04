Class {
	#name : #BlFocusEvent,
	#superclass : #BlBaseFocusEvent,
	#category : 'Bloc-Events'
}

{ #category : 'testing' }
BlFocusEvent >> isFocus [
	^ true
]

{ #category : 'sending' }
BlFocusEvent >> sendTo: anObject [
	anObject focusEvent: self
]
