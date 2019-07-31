Class {
	#name : #BlTktProtoCommand,
	#superclass : #Object,
	#traits : 'TBlTktRequests',
	#classTraits : 'TBlTktRequests classTrait',
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

{ #category : #accessing }
BlTktProtoCommand >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTktProtoCommand >> requestContext [
	<return: #TBlTktRequests>
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

{ #category : #evaluating }
BlTktProtoCommand >> value [
	"execute command and return a result"
	<return: #Object>
	^ self ifExecutionExpectedDo: [ self execute ]
]
