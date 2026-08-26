"
I am a BeaconSignal emitted during a universe pulse cycle (for example when an error occurs during a pulse).
I carry a reference to the error (if any).
"
Class {
	#name : #BlUniversePulseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'error'
	],
	#category : #'Bloc-Universe'
}

{ #category : #accessing }
BlUniversePulseSignal >> error [

	^ error
]

{ #category : #accessing }
BlUniversePulseSignal >> error: anException [

	error := anException
]

{ #category : #accessing }
BlUniversePulseSignal >> signaledError [

	^ error
]

{ #category : #accessing }
BlUniversePulseSignal >> signaledError: anException [

	error := anException
]
