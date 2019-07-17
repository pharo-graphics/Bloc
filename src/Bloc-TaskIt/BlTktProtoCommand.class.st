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

{ #category : #evaluating }
BlTktProtoCommand >> value [
	"execute command and return a result"
	<return: #Object>
	^ self ifExecutionExpectedDo: [ self execute ]
]
