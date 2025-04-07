"
The focusin event fires when an element has received focus, after the focus event. The two events differ in that focusin bubbles, while focus does not.
"
Class {
	#name : #BlFocusInEvent,
	#superclass : #BlBaseFocusEvent,
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlFocusInEvent >> isFocusIn [

	^ true
]

{ #category : #sending }
BlFocusInEvent >> sendTo: anObject [

	anObject focusInEvent: self
]
