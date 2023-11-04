"
The `=BlFocusInEvent`= event is sent to an element when it, or any element inside of it, gains focus. This is distinct from the `=BlFocusEvent`= event, in that it supports detecting the focus event on parent elements (in other words, it supports event bubbling).

"
Class {
	#name : 'BlFocusInEvent',
	#superclass : 'BlBaseFocusEvent',
	#category : 'Bloc-Events'
}

{ #category : 'testing' }
BlFocusInEvent >> isFocusIn [
	^ true
]

{ #category : 'sending' }
BlFocusInEvent >> sendTo: anObject [
	anObject focusInEvent: self
]
