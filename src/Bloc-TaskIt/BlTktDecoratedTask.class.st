Class {
	#name : #BlTktDecoratedTask,
	#superclass : #TKTTask,
	#instVars : [
		'task'
	],
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #converting }
BlTktDecoratedTask >> asLoggingTask [
	^ self
]

{ #category : #initialization }
BlTktDecoratedTask >> initialize [
	super initialize.
	task := nil.
]

{ #category : #accessing }
BlTktDecoratedTask >> name [
	<return: #String>
	^ self task name
]

{ #category : #accessing }
BlTktDecoratedTask >> task [
	<return: #TKTTask>
	^ task
]

{ #category : #accessing }
BlTktDecoratedTask >> task: aTKTTask [
	self 
		assert: [ aTKTTask isNotNil ]
		description: [ 'Task must be non-nil' ].
	task := aTKTTask asTask.
]
