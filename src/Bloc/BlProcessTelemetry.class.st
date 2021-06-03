Class {
	#name : #BlProcessTelemetry,
	#superclass : #ProcessLocalVariable,
	#traits : 'TBlTelemetry',
	#classTraits : 'TBlTelemetry classTrait',
	#classInstVars : [
		'DefaultTelemetryClass'
	],
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #accessing }
BlProcessTelemetry class >> defaultTelemetryClass [
	^ DefaultTelemetryClass ifNil: [ BlNullTelemetry ]
]

{ #category : #accessing }
BlProcessTelemetry class >> defaultTelemetryClass: aClass [
	DefaultTelemetryClass := aClass.
	
	self allInstancesDo: [ :eachProcessTelemetry |
		Process allSubInstancesDo: [ :eachProcess |
			eachProcess
				psValueAt: eachProcessTelemetry index
				put: nil ] ]
]

{ #category : #tasks }
BlProcessTelemetry class >> emit [
	^ self soleInstance emit
]

{ #category : #tasks }
BlProcessTelemetry class >> reset [
	^ self soleInstance reset
]

{ #category : #tasks }
BlProcessTelemetry class >> rootTimeSync: aNameBlock during: aBlock [
	| aTelemetry aResult |
	"we store the telemetry on a stack to prevent it from being garbage collected"
	aTelemetry := self soleInstance ensureValue.

	self value: aTelemetry.
	self reset.
	aResult := self timeSync: aNameBlock
		during: aBlock.
	self emit.

	^ aResult
]

{ #category : #tasks }
BlProcessTelemetry class >> timeSync: aNameBlock during: aBlock [
	^ self soleInstance timeSync: aNameBlock during: aBlock
]

{ #category : #accessing }
BlProcessTelemetry >> default [
	^ self class defaultTelemetryClass new
]

{ #category : #'instance creation' }
BlProcessTelemetry >> emit [
	NonInteractiveTranscript stdout
		nextPutAll: 'Emit! ';
		print: self tasks size;
		cr.

	self tasks ifNotEmpty: [ :theTasks |
		(BlTelemetrySignal new
			task: self tasks asTask;
			telemetry: self) emit ].
	self reset
]

{ #category : #accessing }
BlProcessTelemetry >> ensureValue [
	^ self valueOrNil
		ifNil: [
			| aNewTelemetry |
			
			aNewTelemetry := self default.
			self value: aNewTelemetry.
			aNewTelemetry ]
]

{ #category : #tasks }
BlProcessTelemetry >> finishSync [
	self value finishSync
]

{ #category : #tasks }
BlProcessTelemetry >> reset [
	NonInteractiveTranscript stdout
		nextPutAll: 'Reset!';
		cr.
		
	self value reset
]

{ #category : #tasks }
BlProcessTelemetry >> startSync: aNameBlock [
	self value startSync: aNameBlock
]

{ #category : #tasks }
BlProcessTelemetry >> tasks [
	^ self value tasks
]

{ #category : #tasks }
BlProcessTelemetry >> timeSync: aNameBlock during: aBlock [
	NonInteractiveTranscript stdout
		nextPutAll: 'Time sync! ';
		nextPutAll: aNameBlock value;
		space;
		nextPutAll: self value class name;
		cr.

	self startSync: aNameBlock.
	^ aBlock ensure: [ self finishSync ]
]
