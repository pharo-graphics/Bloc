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
	^ command
]

{ #category : #accessing }
BlTktDecoratedCommand >> command: anObject [
	command := anObject
]

{ #category : #accessing }
BlTktDecoratedCommand >> requestContext [
	<return: #TBlTktRequests>
	^ self command requestContext
]
