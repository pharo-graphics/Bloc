Class {
	#name : #BlTktTerminableCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'taskExecution'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #converting }
BlTktTerminableCommand >> asBlTktTerminableCommand [
	^ self
]

{ #category : #actions }
BlTktTerminableCommand >> cancel [
	self cancelWithReason: 'Termination requested at ', DateAndTime now asString.
]

{ #category : #actions }
BlTktTerminableCommand >> cancelWithReason: aReason [
	self 
		assert: [ aReason isNotNil ]
		description: [ 'Termination reason must be non-nil' ].
	self 
		assert: [ taskExecution isNotNil ]
		description: [ 'Command must be scheduled in a TaskIt worker first' ].
	taskExecution cancelWithReason: aReason
]

{ #category : #evaluating }
BlTktTerminableCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self command execute
]

{ #category : #accessing }
BlTktTerminableCommand >> name [
	<return: #String>
	^ 'Terminable ', self command name
]

{ #category : #accessing }
BlTktTerminableCommand >> taskExecution [
	<return: #TKTTaskExecution>
	^ taskExecution
]

{ #category : #accessing }
BlTktTerminableCommand >> taskExecution: anExecution [
	self 
		assert: [ taskExecution isNil ]
		description: [ 'Terminable command can be executed only once' ].
	self 
		assert: [ anExecution isNotNil ]
		description: [ 'Task execution must be non-nil' ].		
	taskExecution := anExecution
]

{ #category : #actions }
BlTktTerminableCommand >> terminate [
	self terminateWithReason: 'Termination requested at ', DateAndTime now asString.
]

{ #category : #actions }
BlTktTerminableCommand >> terminateWithReason: aReason [
	self 
		assert: [ aReason isNotNil ]
		description: [ 'Termination reason must be non-nil' ].
	self 
		assert: [ taskExecution isNotNil ]
		description: [ 'Command must be scheduled in a TaskIt worker first' ].
	self command canHandleTerminationRequest
		ifTrue: [ self command terminateWithReason: aReason ]
		ifFalse: [ self taskExecution terminateWithReason: aReason ]
]
