Class {
	#name : #BlFocusOutEvent,
	#superclass : #BlBaseFocusEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlFocusOutEvent >> isFocusOut [
	^ true
]

{ #category : #sending }
BlFocusOutEvent >> sendTo: anObject [
	anObject focusOutEvent: self
]
