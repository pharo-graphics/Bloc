"
I simply ignore all events (play a role event recorder in a space)
"
Class {
	#name : #BlEmptyEventRecorder,
	#superclass : #BlSpaceEventRecorder,
	#category : 'Bloc-Space-Support'
}

{ #category : #'api - recording' }
BlEmptyEventRecorder >> record: anEvent [
	"I ignore events"
]
