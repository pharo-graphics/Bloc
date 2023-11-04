Class {
	#name : 'BlTelemetryTasks',
	#superclass : 'LinkedList',
	#package : 'Bloc',
	#tag : 'Space - Telemetry'
}

{ #category : 'converting' }
BlTelemetryTasks >> asTask [
	^ self size = 1
		ifTrue: [ self first ]
		ifFalse: [ BlTelemetryTask new
			name: 'Total';
			startTime: self first startTime;
			endTime: self last endTime;
			tasks: self copy ]
]

{ #category : 'accessing' }
BlTelemetryTasks >> totalDuration [
	^ self
		ifEmpty: [ 0 seconds ]
		ifNotEmpty: [ self sum: [ :eachTask | eachTask duration ] ]
]
