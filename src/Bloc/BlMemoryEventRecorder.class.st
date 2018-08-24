"
I record events in a collection
"
Class {
	#name : #BlMemoryEventRecorder,
	#superclass : #BlSpaceEventRecorder,
	#instVars : [
		'events',
		'time',
		'pulseTimestamp'
	],
	#category : 'Bloc-Space-Support'
}

{ #category : #accessing }
BlMemoryEventRecorder >> events [
	^ events
]

{ #category : #initialization }
BlMemoryEventRecorder >> initialize [
	super initialize.

	events := OrderedCollection new.
	time := BlTime real
]

{ #category : #'api - recording' }
BlMemoryEventRecorder >> onPulse [
	super onPulse.
	
	pulseTimestamp := self time now
]

{ #category : #'api - recording' }
BlMemoryEventRecorder >> record: anEvent [
	| aCopiedEvent |
	
	aCopiedEvent := anEvent copy.
	"we set our own timestamp to be able to differentiate what events were fetched within the same pulse (frame)"
	aCopiedEvent timestamp: pulseTimestamp.

	self events add: aCopiedEvent
]

{ #category : #accessing }
BlMemoryEventRecorder >> time [
	^ time
]
