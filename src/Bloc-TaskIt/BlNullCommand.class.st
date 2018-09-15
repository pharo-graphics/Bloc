Class {
	#name : #BlNullCommand,
	#superclass : #BlCommand,
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

{ #category : #execution }
BlNullCommand >> requestTermination [
	self error: 'You should define what to execute in advance'
]

{ #category : #accessing }
BlNullCommand >> result [
	"Return a command execution result"
	<return: #Object>
	^ nil
]
