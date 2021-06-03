Class {
	#name : #BlTelemetryLogger,
	#superclass : #MemoryLogger,
	#instVars : [
		'telemetryClass'
	],
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #accessing }
BlTelemetryLogger >> nextPut: aSignal [
	(aSignal class == BlTelemetrySignal
		and: [ aSignal telemetry class == self telemetryClass ])
			ifFalse: [ ^ self ].

	super nextPut: aSignal
]

{ #category : #registering }
BlTelemetryLogger >> start [
	super start.
	
	self announcer announce: BlTelemetryLoggerStarted new
]

{ #category : #registering }
BlTelemetryLogger >> stop [
	super stop.
	
	self announcer announce: BlTelemetryLoggerStopped new
]

{ #category : #accessing }
BlTelemetryLogger >> telemetryClass [
	^ telemetryClass
]

{ #category : #accessing }
BlTelemetryLogger >> telemetryClass: anObject [
	telemetryClass := anObject
]

{ #category : #accessing }
BlTelemetryLogger >> totalDuration [
	^ recordings
		inject: 0 milliSeconds
		into: [ :total :each | total + each totalDuration ]
]

{ #category : #'announcer - subscription' }
BlTelemetryLogger >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
