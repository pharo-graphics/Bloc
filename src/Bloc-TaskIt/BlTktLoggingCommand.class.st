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
	BlTaskItSignal emitValuable: self command message: #startValue callingMethod: callingMethod.
	aResult := self command execute.
	BlTaskItSignal emitValuable: self command message: #doneValue callingMethod: callingMethod.
	^ aResult
]

{ #category : #accessing }
BlTktLoggingCommand >> name [
	<return: #String>
	^ 'Logging ', self command name
]
