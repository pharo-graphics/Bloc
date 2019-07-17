Class {
	#name : #BlTktDecoratedCommand,
	#superclass : #BlTktProtoCommand,
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

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
BlTktDecoratedCommand >> requestContext [
	<return: #TBlTktRequests>
	^ self command requestContext
]
