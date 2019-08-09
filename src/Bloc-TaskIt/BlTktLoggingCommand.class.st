Class {
	#name : #BlTktLoggingCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'callingMethod'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #'instance-creation' }
BlTktLoggingCommand class >> command: aCommand [

	^self new 
		command: aCommand asBlTktCommand;
		callingMethod: thisContext sender sender method asRingDefinition;
		yourself
]

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
	BlTaskItSignal emitValuable: self command message: 'start ', self command name callingMethod: callingMethod.
	[ 
		aResult := self command execute.
		BlTaskItSignal emitValuable: self command message: 'done ', self command name callingMethod: callingMethod.
	] on: Error do: [ :anException |
		BlTaskItSignal emitValuable: self command message: 'exception ', self command name callingMethod: callingMethod.
		anException emit.
		anException pass
	].
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
	BlTaskItSignal emitValuable: self command message: 'scheduling ', self command name callingMethod: callingMethod.
	super taskExecution: anExecution.
]
