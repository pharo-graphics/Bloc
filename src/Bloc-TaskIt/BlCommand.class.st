Class {
	#name : #BlCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #testing }
BlCommand class >> isAbstract [
	^ self name = #BlCommand 
]

{ #category : #'instance creation' }
BlCommand class >> null [
	^ BlNullCommand uniqueInstance
]

{ #category : #converting }
BlCommand >> asCommand [
	^ self
]

{ #category : #converting }
BlCommand >> asErrorCatchingCommand [
	<return: #BlErrorCatchingCommand>
	^ BlErrorCatchingCommand new command: self
]

{ #category : #'api - taskit' }
BlCommand >> asLoggingTask [ 
	"Answer the receiver as a task that will log its execution"

	^BlLoggingTask new 
		valuable: self;
		callingMethod: thisContext sender method asRingDefinition;
		yourself
]

{ #category : #'api - taskit' }
BlCommand >> asTask [
	^ TKTTask valuable: self
]

{ #category : #'api - execution' }
BlCommand >> cancelRequest [
	"Every command is responsible to terminate nicely"
	self subclassResponsibility
]

{ #category : #accessing }
BlCommand >> catchingErrors [
	"Return an error or collections of errors to catch during a command execution"
	^ Error
]

{ #category : #evaluating }
BlCommand >> cull: anArg [
	^ self numberOfArguments = 0
		ifTrue: [ self value ]
		ifFalse: [ self value: anArg ]
]

{ #category : #evaluating }
BlCommand >> cull: firstArg cull: secondArg [
	^ self numberOfArguments < 2
		ifTrue: [self cull: firstArg]
		ifFalse: [self value: firstArg value: secondArg]
	
]

{ #category : #evaluating }
BlCommand >> cull: firstArg cull: secondArg cull: thirdArg [
	^ self numberOfArguments < 3
		ifTrue: [self cull: firstArg cull: secondArg]
		ifFalse: [self value: firstArg value: secondArg value: thirdArg]
	
]

{ #category : #evaluating }
BlCommand >> cull: firstArg cull: secondArg cull: thirdArg cull: fourthArg [
	^ self numberOfArguments < 4
		ifTrue: [self cull: firstArg cull: secondArg cull: thirdArg]
		ifFalse: [self value: firstArg value: secondArg value: thirdArg value: fourthArg]
	
]

{ #category : #'api - execution' }
BlCommand >> execute [
	self subclassResponsibility
]

{ #category : #'api - taskit' }
BlCommand >> future [
	^ BlAsyncUIWorkerPool future: self maxPoolSize: 4
]

{ #category : #evaluating }
BlCommand >> numberOfArguments [
	^ 0
]

{ #category : #'api - execution' }
BlCommand >> result [
	"Return a command execution result"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #'api - taskit' }
BlCommand >> schedule [
	^ BlAsyncUIWorkerPool schedule: self maxPoolSize: 4
]

{ #category : #'api - taskit' }
BlCommand >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]

{ #category : #evaluating }
BlCommand >> value [
	^ self execute; result
]

{ #category : #'api - testing' }
BlCommand >> wasCanceled [
	"Answer whether an execution was canceled"
	<return: #Boolean>
	^ self subclassResponsibility
]
