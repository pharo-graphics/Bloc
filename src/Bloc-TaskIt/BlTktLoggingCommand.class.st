Class {
	#name : #BlTktLoggingCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'callingMethod'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #'instance-creation' }
BlTktLoggingCommand class >> valuable: aValuable [

	^self new 
		command: aValuable asBlTktCommand;
		callingMethod: thisContext sender sender method asRingDefinition;
		yourself
]

{ #category : #converting }
BlTktLoggingCommand >> asBlTktLoggingCommand [
	^ self
]

{ #category : #accessing }
BlTktLoggingCommand >> callingMethod [
	^ callingMethod
]

{ #category : #accessing }
BlTktLoggingCommand >> callingMethod: anObject [
	callingMethod := anObject
]

{ #category : #executing }
BlTktLoggingCommand >> execute [
	| aResult |
	BlTaskItSignal emitValuable: self command message: #startExecution callingMethod: callingMethod.
	aResult := self command execute.
	BlTaskItSignal emitValuable: self command message: #doneExecution callingMethod: callingMethod.
	^ aResult
]

{ #category : #testing }
BlTktLoggingCommand >> includesLoggingCommand [
	<return: #Boolean>
	^ true
]

{ #category : #accessing }
BlTktLoggingCommand >> name [
	<return: #String>
	^ 'Logging ', self command name
]

{ #category : #taskit }
BlTktLoggingCommand >> taskExecution: anExecution [
	BlTaskItSignal emitValuable: self command message: #scheduling callingMethod: callingMethod.
	super taskExecution: anExecution.
]
