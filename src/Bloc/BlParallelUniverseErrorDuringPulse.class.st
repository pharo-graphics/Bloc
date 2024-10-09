"
I am a signal that is raised when there is an error in the pulse.
I include in myself the signaledError.
"
Class {
	#name : #BlParallelUniverseErrorDuringPulse,
	#superclass : #BeaconSignal,
	#instVars : [
		'universeId',
		'signaledError'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseErrorDuringPulse >> signaledError [

	^ signaledError
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulse >> signaledError: anObject [

	signaledError := anObject
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulse >> universeId [
	^ universeId
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulse >> universeId: aNumber [
	universeId := aNumber
]
