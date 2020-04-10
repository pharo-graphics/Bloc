Class {
	#name : #BlTktWrapperCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #accessing }
BlTktWrapperCommand >> command [
	"Return a command that understands #execute"
	^ command
]

{ #category : #accessing }
BlTktWrapperCommand >> command: aCommand [
	self
		assert: [ aCommand isNotNil ]
		description: [ 'Command must be non-nil' ].
	command := aCommand
]

{ #category : #accessing }
BlTktWrapperCommand >> entryIdentifier [
	^ self command entryIdentifier
]

{ #category : #evaluating }
BlTktWrapperCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self command execute
]

{ #category : #accessing }
BlTktWrapperCommand >> name [
	<return: #String>
	^ self command printString
]
