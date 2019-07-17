Class {
	#name : #BlTktProtoCommand,
	#superclass : #Object,
	#traits : 'TBlTktRequests',
	#classTraits : 'TBlTktRequests classTrait',
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #converting }
BlTktProtoCommand >> asAnnouncingCommand [
	<return: #BlTktAnnouncingCommand>
	^ BlTktAnnouncingCommand new command: self.
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
	^ self scheduleInPool: BlAsyncUIWorkerPool default.
]

{ #category : #evaluating }
BlTktProtoCommand >> value [
	"execute command and return a result"
	<return: #Object>
	^ self ifExecutionExpectedDo: [ self execute ]
]
