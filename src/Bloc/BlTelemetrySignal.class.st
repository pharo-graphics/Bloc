Class {
	#name : 'BlTelemetrySignal',
	#superclass : 'BeaconSignal',
	#instVars : [
		'task',
		'telemetry'
	],
	#category : 'Bloc-Space - Telemetry'
}

{ #category : 'accessing' }
BlTelemetrySignal >> duration [
	^ self task duration
]

{ #category : 'accessing' }
BlTelemetrySignal >> gtMapFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Map';
		priority: 0;
		object: [ self task ];
		view: #gtMapFor:
]

{ #category : 'accessing' }
BlTelemetrySignal >> signal [
	<objectGetter: #telemetrySignal>
	<return: #BlTelemetrySignal>

	^ self
]

{ #category : 'accessing' }
BlTelemetrySignal >> task [
	<return: #BlTelemetryTask>

	^ task
]

{ #category : 'accessing' }
BlTelemetrySignal >> task: aBlTelemetryTask [
	task := aBlTelemetryTask
]

{ #category : 'accessing' }
BlTelemetrySignal >> telemetry [
	^ telemetry
]

{ #category : 'accessing' }
BlTelemetrySignal >> telemetry: anObject [
	telemetry := anObject
]
