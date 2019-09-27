"
Is sent when element's extent in local coordinates changes.
"
Class {
	#name : #BlElementExtentChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlElementExtentChangedEvent >> sendTo: anObject [
	anObject elementExtentChanged: self
]
