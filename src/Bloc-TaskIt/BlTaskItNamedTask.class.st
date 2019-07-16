Class {
	#name : #BlTaskItNamedTask,
	#superclass : #BlTktDecoratedTask,
	#instVars : [
		'name'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #converting }
BlTaskItNamedTask >> asNamedTask [
	^ self
]

{ #category : #initialization }
BlTaskItNamedTask >> initialize [
	super initialize.
	name := '<nameless>'.
]

{ #category : #accessing }
BlTaskItNamedTask >> name [
	<return: #String>
	^ name
]

{ #category : #accessing }
BlTaskItNamedTask >> name: aString [
	self 
		assert: [ aString isString and: [ aString isEmpty not ] ]
		description: [ 'Task name must be non-nil and non-empty string' ].
	name := aString
]

{ #category : #printing }
BlTaskItNamedTask >> printOn: aStream [
	self name isNil ifTrue: [ super printOn: aStream. ^ self ].
	aStream
		nextPutAll: 'Task named ';
		print: self name;
		nextPutAll: ', executing: ';
		print: self task.
]

{ #category : #executing }
BlTaskItNamedTask >> value [
	| aResult anOldNameOrNil anActiveProcess aTempName aTaskName |
	self
		assert: [ self task isNil not ]
		description: [ 'Named task must be initialized before using it' ].
	anActiveProcess := Processor activeProcess.
	anOldNameOrNil := anActiveProcess gtName.
	aTempName := anOldNameOrNil
		ifNil: [ '' ]
		ifNotNil: [ anOldNameOrNil asString ].
	aTaskName := 'Task: ''', self name, ''' in ' , aTempName.
	anActiveProcess name: aTaskName.
	aResult := self task value.
	anActiveProcess name: anOldNameOrNil.
	^ aResult
]
