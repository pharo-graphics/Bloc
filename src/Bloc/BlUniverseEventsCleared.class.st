"
Emitted when all of the event loop's events have been processed and control flow is about to be taken away from the Universe.
"
Class {
	#name : #BlUniverseEventsCleared,
	#superclass : #BlUniverseEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlUniverseEventsCleared >> sendTo: anObject [
	anObject eventsCleared: self
]
