"
I am a signal that is raised when there is an error in the pulse.
I include in myself the signaledError.
"
Class {
	#name : 'BlParallelUniverseErrorDuringPulse',
	#superclass : 'BlParallelUniverseSignal',
	#instVars : [
		'signaledError'
	],
	#category : 'Bloc-Universe - Parallel',
	#package : 'Bloc',
	#tag : 'Universe - Parallel'
}

{ #category : 'accessing' }
BlParallelUniverseErrorDuringPulse >> signaledError [

	^ signaledError
]

{ #category : 'accessing' }
BlParallelUniverseErrorDuringPulse >> signaledError: anObject [

	signaledError := anObject
]
