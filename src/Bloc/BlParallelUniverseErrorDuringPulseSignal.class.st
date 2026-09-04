"
I am a signal that is raised when there is an error in the pulse.
I include in myself the error.
"
Class {
	#name : #BlParallelUniverseErrorDuringPulseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'error'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseErrorDuringPulseSignal >> error [

	^ error
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulseSignal >> error: anException [

	error := anException
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulseSignal >> signaledError [

	self
		deprecated: 'Use #error instead'
		transformWith: '`@receiver signaledError' -> '`@receiver error'.

	^ self error
]

{ #category : #accessing }
BlParallelUniverseErrorDuringPulseSignal >> signaledError: anException [

	self
		deprecated: 'Use #error: instead'
		transformWith: '`@receiver signaledError: `@arg' -> '`@receiver error: `@arg'.

	self error: anException
]
