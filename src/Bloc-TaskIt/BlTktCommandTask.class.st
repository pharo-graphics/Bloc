Class {
	#name : #BlTktCommandTask,
	#superclass : #TKTTask,
	#traits : 'TBlDebug + TBlTktRequests',
	#classTraits : 'TBlDebug classTrait + TBlTktRequests classTrait',
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #accessing }
BlTktCommandTask >> command [
	<return: #BlTktProtoCommand>
	^ command
]

{ #category : #accessing }
BlTktCommandTask >> command: aCommand [
	self
		assert: [ aCommand isNotNil ]
		description: [ 'Command must be non-nil' ].
	command := aCommand
]

{ #category : #executing }
BlTktCommandTask >> futureTaskExecutionFor: aRunner [
	^ self configureTaskExecution: BlTktCommandTaskFutureExecution new with: aRunner
]

{ #category : #accessing }
BlTktCommandTask >> name [
	<return: #String>
	^ self command name
]

{ #category : #accessing }
BlTktCommandTask >> requestContext [
	<return: #TBlTktRequests>
	^ self command
]

{ #category : #executing }
BlTktCommandTask >> scheduleTaskExecutionFor: aRunner [
	^ self configureTaskExecution: BlTktCommandTaskExecution new with: aRunner
]

{ #category : #executing }
BlTktCommandTask >> value [
	^ self command value
]
