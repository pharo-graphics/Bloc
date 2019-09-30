"
Is sent when elemen't position in space coordinates changes.

Position in space may change even if element's #position is still the same. It can happen when any of its parents moves.
"
Class {
	#name : #BlElementPositionInSpaceChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlElementPositionInSpaceChangedEvent >> sendTo: anObject [
	anObject elementPositionInSpaceChanged: self
]
