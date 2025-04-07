"
The focus event fires when an element has received focus. The event does not bubble, but the related `BlFocusInEvent` that follows does bubble.
"
Class {
	#name : #BlFocusEvent,
	#superclass : #BlBaseFocusEvent,
	#category : #'Bloc-Events'
}

{ #category : #initialization }
BlFocusEvent >> initialize [

	super initialize.

	"By definition, this event does not bubble."
	self canBePropagated: false
]

{ #category : #testing }
BlFocusEvent >> isFocus [

	^ true
]

{ #category : #sending }
BlFocusEvent >> sendTo: anObject [

	anObject focusEvent: self
]
