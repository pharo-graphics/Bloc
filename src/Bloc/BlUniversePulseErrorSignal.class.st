"
I am a BeaconSignal emitted when an error occurs during a universe pulse cycle.
I carry a reference to the signaled error.
"
Class {
	#name : #BlUniversePulseErrorSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'error'
	],
	#category : #'Bloc-Universe'
}

{ #category : #accessing }
BlUniversePulseErrorSignal >> error [

	^ error
]

{ #category : #accessing }
BlUniversePulseErrorSignal >> error: anException [

	error := anException
]

{ #category : #accessing }
BlUniversePulseErrorSignal >> signaledError [

	^ error
]

{ #category : #accessing }
BlUniversePulseErrorSignal >> signaledError: anException [

	error := anException
]
