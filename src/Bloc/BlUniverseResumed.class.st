"
Emitted when the Universe has been resumed.
"
Class {
	#name : #BlUniverseResumed,
	#superclass : #BlUniverseEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlUniverseResumed >> sendTo: anObject [
	anObject universeResumed: self
]
