"
The blur event fires when an element has lost focus. The event does not bubble, but the related `BlFocusOutEvent` event that follows does bubble.
"
Class {
	#name : #BlBlurEvent,
	#superclass : #BlBaseFocusEvent,
	#instVars : [
		'dueToRemoval'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlBlurEvent >> dueToRemoval: aBoolean [

	dueToRemoval := aBoolean
]

{ #category : #initialization }
BlBlurEvent >> initialize [

	super initialize.

	"By definition, this event does not bubble."
	self canBePropagated: false
]

{ #category : #testing }
BlBlurEvent >> isBlur [

	^ true
]

{ #category : #accessing }
BlBlurEvent >> isDueToRemoval [

	^ dueToRemoval
]

{ #category : #sending }
BlBlurEvent >> sendTo: anObject [

	anObject blurEvent: self
]
