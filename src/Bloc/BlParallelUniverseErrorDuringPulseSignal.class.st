"
I am a signal that is raised when there is an error in the pulse.
I include in myself the signaledError.
"
Class {
	#name : #BlParallelUniverseErrorDuringPulseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'signaledError'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseErrorDuringPulseSignal >> signaledError [

	^ signaledError
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulseSignal >> signaledError: anObject [

	signaledError := anObject
]
