Class {
	#name : #BlTaskItNamedTask,
	#superclass : #TKTTask,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'task',
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
	task := nil.
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

{ #category : #accessing }
BlTaskItNamedTask >> task [
	<return: #TKTTask>
	^ task
]

{ #category : #accessing }
BlTaskItNamedTask >> task: aTKTTask [
	self 
		assert: [ aTKTTask isNotNil ]
		description: [ 'Task must be non-nil' ].
	task := aTKTTask asTask.
]

{ #category : #executing }
BlTaskItNamedTask >> value [
	self 
		assert: [ self task isNil not ]
		description: [ 'Named task must be initialized before using it' ].
	^ self task value
]
