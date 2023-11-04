"
I simply ignore all events (play a role event recorder in a space)

"
Class {
	#name : 'BlEmptyEventRecorder',
	#superclass : 'BlSpaceEventRecorder',
	#package : 'Bloc',
	#tag : 'Space - Events'
}

{ #category : 'api - recording' }
BlEmptyEventRecorder >> record: anEvent [
	"I ignore events"
]
