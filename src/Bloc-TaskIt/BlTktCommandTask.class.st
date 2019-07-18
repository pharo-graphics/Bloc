Class {
	#name : #BlTktCommandTask,
	#superclass : #TKTTask,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
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
BlTktCommandTask >> scheduleTaskExecutionFor: aRunner [
	^ self configureTaskExecution: BlTktCommandTaskExecution new with: aRunner
]

{ #category : #executing }
BlTktCommandTask >> value [
	^ self command value
]
