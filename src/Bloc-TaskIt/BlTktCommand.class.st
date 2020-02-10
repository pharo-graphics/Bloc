Class {
	#name : #BlTktCommand,
	#superclass : #BlTktProtoCommand,
	#instVars : [
		'name'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #accessing }
BlTktCommand class >> defaultName [
	^ 'Default'
]

{ #category : #factory }
BlTktCommand class >> null [
	^ BlTktNullCommand uniqueInstance
]

{ #category : #accessing }
BlTktCommand >> catchingErrors [
	"Return an error or collections of errors to catch during a command execution"
	^ Error
]

{ #category : #initialization }
BlTktCommand >> initialize [
	super initialize.
	
	name := self class defaultName
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
