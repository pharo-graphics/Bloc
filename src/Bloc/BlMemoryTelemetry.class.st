Class {
	#name : #BlMemoryTelemetry,
	#superclass : #BlTelemetry,
	#instVars : [
		'tasks',
		'tasksStack'
	],
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #tasks }
BlMemoryTelemetry >> finishSync [
	| anEndTime |
	tasksStack
		ifEmpty: [ ^ self ].

	anEndTime := Time microsecondClockValue.

	tasksStack pop
		realEndTime: Time microsecondClockValue;
		endTime: anEndTime
]

{ #category : #initialization }
BlMemoryTelemetry >> initialize [
	super initialize.
	
	tasks := BlTelemetryTasks new.
	tasksStack := Stack new.
]

{ #category : #tasks }
BlMemoryTelemetry >> reset [
	[ tasksStack isNotEmpty ]
		whileTrue: [ self finishSync ].

	tasks removeAll.
	tasksStack removeAll
]

{ #category : #tasks }
BlMemoryTelemetry >> startSync: aNameBlock [
	| aNewTask aRealStart |
	
	aRealStart := Time microsecondClockValue.
	
	aNewTask := BlTelemetryTask new.
	aNewTask name: aNameBlock value.
	
	tasksStack
		ifEmpty: [ tasks add: aNewTask ]
		ifNotEmpty: [ tasksStack top addTask: aNewTask ].

	tasksStack push: aNewTask.
	
	aNewTask realStartTime: aRealStart.
	aNewTask startTime: Time microsecondClockValue
]

{ #category : #tasks }
BlMemoryTelemetry >> tasks [
	^ tasks
]
