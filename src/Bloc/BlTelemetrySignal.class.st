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
BlTelemetrySignal >> gtMapFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Map';
		priority: 0;
		object: [ self task ];
		view: #gtMapFor:
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
