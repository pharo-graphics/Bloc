"
Is sent when element's position within its parent changes.

Note: position may change even if an element has no parent
"
Class {
	#name : #BlElementPositionChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlElementPositionChangedEvent >> sendTo: anObject [
	anObject elementPositionChanged: self
]
