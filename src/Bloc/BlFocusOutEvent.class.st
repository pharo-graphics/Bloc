"
The focusout event fires when an element has lost focus, after the blur event. The two events differ in that `BlFocusOutEvent` bubbles, while `BlBlurEvent` does not.
"
Class {
	#name : #BlFocusOutEvent,
	#superclass : #BlBaseFocusEvent,
	#instVars : [
		'dueToRemoval'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlFocusOutEvent >> dueToRemoval: aBoolean [

	dueToRemoval := aBoolean
]

{ #category : #accessing }
BlFocusOutEvent >> isDueToRemoval [

	^ dueToRemoval
]

{ #category : #testing }
BlFocusOutEvent >> isFocusOut [

	^ true
]

{ #category : #sending }
BlFocusOutEvent >> sendTo: anObject [

	anObject focusOutEvent: self
]
