Class {
	#name : #BlTktProtoCommand,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #converting }
BlTktProtoCommand >> asAnnouncingCommand [
	<return: #BlTktAnnouncingCommand>
	^ BlTktAnnouncingCommand new command: self.
]

{ #category : #converting }
BlTktProtoCommand >> asBlTktCommand [
	^ self
]

{ #category : #converting }
BlTktProtoCommand >> asBlTktLoggingCommand [
	^ BlTktLoggingCommand new command: self
]

{ #category : #converting }
BlTktProtoCommand >> asBlTktTerminableCommand [
	^ BlTktTerminableCommand new command: self
]

{ #category : #converting }
BlTktProtoCommand >> asErrorCatchingCommand [
	<return: #BlErrorCatchingCommand>
	^ BlErrorCatchingCommand new command: self
]

{ #category : #converting }
BlTktProtoCommand >> asResultPreservingCommand [
	<return: #BlTktPreservingResultCommand>
	^ BlTktPreservingResultCommand new command: self
]

{ #category : #taskit }
BlTktProtoCommand >> asTask [
	<return: #BlTktCommandTask>
	^ BlTktCommandTask new command: self.
]

{ #category : #taskit }
BlTktProtoCommand >> canHandleTerminationRequest [
	<return: #Boolean>
	^ false
]

{ #category : #evaluating }
BlTktProtoCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #taskit }
BlTktProtoCommand >> future [
	^ self futureInUIPool
]

{ #category : #taskit }
BlTktProtoCommand >> futureInPool: aWorkerPool [
	<return: #TKTFuture>
	^ aWorkerPool future: self
]

{ #category : #taskit }
BlTktProtoCommand >> futureInUIPool [
	^ self futureInPool: BlTktWorkerProvider highUICPUBoundPool
]

{ #category : #testing }
BlTktProtoCommand >> includesLoggingCommand [
	<return: #Boolean>
	^ false
]

{ #category : #accessing }
BlTktProtoCommand >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTktProtoCommand >> name: aString [
	^ self subclassResponsibility
]

{ #category : #taskit }
BlTktProtoCommand >> schedule [
	^ self scheduleInUIPool
]

{ #category : #taskit }
BlTktProtoCommand >> scheduleInPool: aWorkerPool [
	<return: #TKTTask>
	| aTask |
	aTask := self asTask.
	aWorkerPool schedule: aTask.
	^ aTask
]

{ #category : #taskit }
BlTktProtoCommand >> scheduleInUIPool [
	<return: #TKTTask>
	^ self scheduleInPool: BlTktWorkerProvider highUICPUBoundPool.
]

{ #category : #taskit }
BlTktProtoCommand >> taskExecution: anExecution [
	"do nothing"
]

{ #category : #evaluating }
BlTktProtoCommand >> value [
	"execute command and return a result"
	<return: #Object>
	^ self execute
]
