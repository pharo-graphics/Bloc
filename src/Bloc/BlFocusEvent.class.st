Class {
	#name : #BlFocusEvent,
	#superclass : #BlBaseFocusEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlFocusEvent >> isFocus [
	^ true
]

{ #category : #sending }
BlFocusEvent >> sendTo: anObject [
	anObject focusEvent: self
]
