Class {
	#name : #BlTelemetry,
	#superclass : #Object,
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #'instance creation' }
BlTelemetry >> emit [
	(BlTelemetrySignal new task: self tasks asTask) emit.
	self reset
]

{ #category : #tasks }
BlTelemetry >> finishSync [
]

{ #category : #tasks }
BlTelemetry >> reset [
]

{ #category : #tasks }
BlTelemetry >> startSync: aNameBlock [
]

{ #category : #tasks }
BlTelemetry >> tasks [
	^#()
]

{ #category : #tasks }
BlTelemetry >> timeSync: aNameBlock during: aBlock [
	self startSync: aNameBlock.
	^ aBlock ensure: [ self finishSync ]
]
