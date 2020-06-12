Class {
	#name : #BlTelemetryLogger,
	#superclass : #CircularMemoryLogger,
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #accessing }
BlTelemetryLogger >> nextPut: aSignal [
	aSignal class == BlTelemetrySignal
		ifFalse: [ ^ self ].

	super nextPut: aSignal
]

{ #category : #accessing }
BlTelemetryLogger >> totalDuration [
	^ recordings
		inject: 0 milliSeconds
		into: [ :total :each | total + each totalDuration ]
]
