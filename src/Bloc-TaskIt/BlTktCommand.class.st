Class {
	#name : #BlTktCommand,
	#superclass : #BlTktProtoCommand,
	#instVars : [
		'requests',
		'name'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #initialization }
BlTktCommand >> initialize [
	super initialize.
	requests := BlTktCommandRequests new.
]

{ #category : #accessing }
BlTktCommand >> name [
	self
		assert: [ name isNotNil ]
		description: [ 'Task name must be initialized before use' ].
	^ name
]

{ #category : #accessing }
BlTktCommand >> name: aString [
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty ] ] 
		description: [ 'Task name must be a non-empty string' ].
	name := aString
]

{ #category : #accessing }
BlTktCommand >> requestContext [
	<return: #TBlTktRequests>
	^ requests
]
