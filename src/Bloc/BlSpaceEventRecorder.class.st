"
I am used to record space events coming from the host window
"
Class {
	#name : #BlSpaceEventRecorder,
	#superclass : #Object,
	#category : #'Bloc-Space - Events'
}

{ #category : #'api - recording' }
BlSpaceEventRecorder >> onPulse [
	"Is sent by the space right before it starts fetching events"
]

{ #category : #'api - recording' }
BlSpaceEventRecorder >> record: anEvent [
	self subclassResponsibility
]
