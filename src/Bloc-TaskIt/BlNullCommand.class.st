Class {
	#name : #BlNullCommand,
	#superclass : #BlTktProtoCommand,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #cleanup }
BlNullCommand class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
BlNullCommand class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
BlNullCommand class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #execution }
BlNullCommand >> execute [
	self error: 'You should define what to execute in advance'
]

{ #category : #accessing }
BlNullCommand >> name [
	<return: #String>
	^ 'NULL command'
]

{ #category : #accessing }
BlNullCommand >> name: aString [
	"ignore"
]

{ #category : #'api - execution' }
BlNullCommand >> terminationRequested [
	"I silently ignore the cancel request as I do not execute anything."
]

{ #category : #'api - testing' }
BlNullCommand >> wasCanceled [
	"I cannot be canceled"
	^ false
]
