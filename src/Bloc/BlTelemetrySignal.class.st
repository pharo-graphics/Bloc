Class {
	#name : #BlTelemetrySignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'task'
	],
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #accessing }
BlTelemetrySignal >> duration [
	^ self task duration
]

{ #category : #accessing }
BlTelemetrySignal >> task [
	<return: #BlTelemetryTask>

	^ task
]

{ #category : #accessing }
BlTelemetrySignal >> task: aBlTelemetryTask [
	task := aBlTelemetryTask
]
