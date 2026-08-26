"
I am a deprecated BeaconSignal. Use `BlUniversePulseErrorSignal` instead.
"
Class {
	#name : #BlParallelUniverseErrorDuringPulseSignal,
	#superclass : #BlUniversePulseErrorSignal,
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #testing }
BlParallelUniverseErrorDuringPulseSignal class >> isDeprecated [

	^ true
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
