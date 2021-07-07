"
I use {{gtClass:Beacon}} to log when a {{gtClass:BlTask}} is scheduled and executed..
I emit {{gtClass:BlBeaconTaskSignal}}.
I should be instantiated using {{gtMethod:BlBeaconLoggingTask class>>#subtask:}}.


"
Class {
	#name : #BlBeaconLoggingTask,
	#superclass : #BlTask,
	#instVars : [
		'name',
		'subtask',
		'callingMethod'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlBeaconLoggingTask class >> subtask: aBlTask [
	<return: #BlBeaconLoggingTask>
	^ self new
		subtask: aBlTask;
		callingMethod: thisContext sender sender blocMethodDefinition
]

{ #category : #converting }
BlBeaconLoggingTask >> asBeaconLoggingTask [
	^ self
]

{ #category : #accessing }
BlBeaconLoggingTask >> callingMethod [
	^ callingMethod
]

{ #category : #accessing }
BlBeaconLoggingTask >> callingMethod: anObject [
	callingMethod := anObject
]

{ #category : #accessing }
BlBeaconLoggingTask >> maySetName: aString [
	name ifNotNil: [ ^ self ].
	self name: aString
]

{ #category : #accessing }
BlBeaconLoggingTask >> name [
	^ name ifNil: [ '' ]
]

{ #category : #accessing }
BlBeaconLoggingTask >> name: anObject [
	name := anObject
]

{ #category : #hooks }
BlBeaconLoggingTask >> onEnqueued: aBlSpace [
	"Is self when a task is enqueued in a space.
	It gives subclasses a possibility to synchronize time with the space"
	BlBeaconTaskSignal new task: self subtask; name: self name message: #enqueuedBlocTask; callingMethod: callingMethod; emit.
	self subtask onEnqueued: aBlSpace
]

{ #category : #hooks }
BlBeaconLoggingTask >> onEnqueuedInElement: aBlElement [
	"Is sent when a task is enqueued in a element.
	It gives subclasses a possibility to re-enqueue themselves in the same element"
	BlBeaconTaskSignal new task: self subtask; name: self name message: #enqueuedBlocTaskInElement; callingMethod: callingMethod; emit.
	self subtask onEnqueuedInElement: aBlElement
]

{ #category : #'api - running' }
BlBeaconLoggingTask >> run [
	BlBeaconTaskSignal new task: self subtask; name: self name message: #runBlocTask; callingMethod: callingMethod; emit.
	self subtask run.
	BlBeaconTaskSignal new task: self subtask; name: self name message: #doneBlocTask; callingMethod: callingMethod; emit.	
]

{ #category : #accessing }
BlBeaconLoggingTask >> subtask [
	<return: #BlTask>
	^ subtask
]

{ #category : #accessing }
BlBeaconLoggingTask >> subtask: aBlTask [
	self 
		assert: [ aBlTask isNotNil ]
		description: [ 'Sub-Task must be non-nil' ].
	subtask := aBlTask
]
