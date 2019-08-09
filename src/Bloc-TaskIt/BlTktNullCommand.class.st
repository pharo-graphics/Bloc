Class {
	#name : #BlTktNullCommand,
	#superclass : #BlTktProtoCommand,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #cleanup }
BlTktNullCommand class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
BlTktNullCommand class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
BlTktNullCommand class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #execution }
BlTktNullCommand >> execute [
	self error: 'You should define what to execute in advance'
]

{ #category : #accessing }
BlTktNullCommand >> name [
	<return: #String>
	^ 'NULL command'
]

{ #category : #accessing }
BlTktNullCommand >> name: aString [
	"ignore"
]

{ #category : #'api - execution' }
BlTktNullCommand >> terminationRequested [
	"I silently ignore the cancel request as I do not execute anything."
]

{ #category : #'api - testing' }
BlTktNullCommand >> wasCanceled [
	"I cannot be canceled"
	^ false
]
