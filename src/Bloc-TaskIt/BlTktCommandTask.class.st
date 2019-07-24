Class {
	#name : #BlTktCommandTask,
	#superclass : #TKTTask,
	#traits : 'TBlDebug + TBlTktRequests',
	#classTraits : 'TBlDebug classTrait + TBlTktRequests classTrait',
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-TaskIt Tasks'
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
	command := aCommand asBlTktCommand
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

{ #category : #printing }
BlTktCommandTask >> printOn: aStream [
	self command ifNil: [ super printOn: aStream. ^ self ].
	self name ifNil: [ super printOn: aStream. ^ self ].
	aStream
		nextPutAll: 'Task named ';
		print: self name.
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
	| aResult anOldNameOrNil anActiveProcess aTempName aTaskName |
	self
		assert: [ self command isNil not ]
		description: [ 'Command task must be initialized before using it' ].
	anActiveProcess := Processor activeProcess.
	anOldNameOrNil := anActiveProcess gtName.
	aTempName := anOldNameOrNil
		ifNil: [ '' ]
		ifNotNil: [ anOldNameOrNil asString ].
	aTaskName := 'Task: ''', self name, ''' in ' , aTempName.
	anActiveProcess task: self.
	anActiveProcess name: aTaskName.
	aResult := self command value.
	anActiveProcess name: anOldNameOrNil.
	^ aResult
]
