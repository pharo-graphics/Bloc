Class {
	#name : #BlTktDecoratedCommand,
	#superclass : #BlTktProtoCommand,
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #accessing }
BlTktDecoratedCommand >> catchingErrors [
	^ command catchingErrors
]

{ #category : #accessing }
BlTktDecoratedCommand >> command [
	<return: #BlTktProtoCommand>
	^ command
]

{ #category : #accessing }
BlTktDecoratedCommand >> command: aCommand [
	self
		assert: [ aCommand isNotNil ]
		description: [ 'Command must be non-nil' ].
	command := aCommand
]

{ #category : #accessing }
BlTktDecoratedCommand >> name: aString [
	self command name: aString
]
