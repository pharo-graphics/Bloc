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

{ #category : #converting }
BlCommand >> asCommand [
	^ self
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
	^ self asTask future
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
	^ self asTask schedule
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
