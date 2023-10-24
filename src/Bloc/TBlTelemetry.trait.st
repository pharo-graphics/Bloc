Trait {
	#name : #TBlTelemetry,
	#category : 'Bloc-Space - Telemetry'
}

{ #category : #'instance creation' }
TBlTelemetry >> emit [
	self tasks ifNotEmpty: [ :theTasks |
		(BlTelemetrySignal new
			task: self tasks asTask;
			telemetry: self) emit ].
	self reset
]

{ #category : #tasks }
TBlTelemetry >> finishSync [
]

{ #category : #tasks }
TBlTelemetry >> reset [
]

{ #category : #tasks }
TBlTelemetry >> startSync: aNameBlock [
]

{ #category : #tasks }
TBlTelemetry >> tasks [
	^ BlTelemetryTasks new
]

{ #category : #tasks }
TBlTelemetry >> timeSync: aNameBlock during: aBlock [
	self startSync: aNameBlock.
	^ aBlock ensure: [ self finishSync ]
]
