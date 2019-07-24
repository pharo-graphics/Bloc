Class {
	#name : #BlErrorCatchingCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'isException',
		'exception'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #converting }
BlErrorCatchingCommand >> asErrorCatchingCommand [
	<return: #BlErrorCatchingCommand>
	^ self
]

{ #category : #accessing }
BlErrorCatchingCommand >> exception [
	<return: #Exception or: nil>
	^ exception
]

{ #category : #execution }
BlErrorCatchingCommand >> execute [
	[ 
		command execute.
		exception := nil.
	] on: self catchingErrors do: [ :anException |
		anException freeze.
		exception := anException.
	].
]

{ #category : #initialization }
BlErrorCatchingCommand >> initialize [
	super initialize.
	exception := nil.
]

{ #category : #testing }
BlErrorCatchingCommand >> isException [
	"Return true, if evaluation raised an exception"
	<return: #Boolean>
	^ self exception notNil
]

{ #category : #accessing }
BlErrorCatchingCommand >> name [
	<return: #String>
	^ 'Error catching ', self command name
]

{ #category : #accessing }
BlErrorCatchingCommand >> resultObsolete [
	"Return a command execution result"
	<return: #Object>
	^ self isException 
		ifTrue: [ self exception ] 
		ifFalse: [ self command result ]
]
