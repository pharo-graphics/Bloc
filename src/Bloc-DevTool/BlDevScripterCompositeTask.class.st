Class {
	#name : #BlDevScripterCompositeTask,
	#superclass : #BlDevScripterTask,
	#traits : 'TBlDevScripterTarget',
	#classTraits : 'TBlDevScripterTarget classTrait',
	#instVars : [
		'label',
		'tasks'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #adding }
BlDevScripterCompositeTask >> addTask: aTask [
	tasks add: aTask.
	^ aTask
]

{ #category : #actions }
BlDevScripterCompositeTask >> continueOn: aScripter [
	self wasExecuted 
		ifTrue: [ self tasks do: [ :eachTask | eachTask continueOn: aScripter ] ]
		ifFalse: [ self playIndicatingStateOn: aScripter ].
]

{ #category : #accessing }
BlDevScripterCompositeTask >> defaultLabel [
	^ 'Tasks'
]

{ #category : #initialization }
BlDevScripterCompositeTask >> initialize [
	super initialize.
	
	tasks := OrderedCollection new
]

{ #category : #accessing }
BlDevScripterCompositeTask >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlDevScripterCompositeTask >> label: anObject [
	label := anObject
]

{ #category : #actions }
BlDevScripterCompositeTask >> playOn: aScripter [
	self tasks do: [ :eachTask | eachTask playIndicatingStateOn: aScripter ]
]

{ #category : #accessing }
BlDevScripterCompositeTask >> target [
	<return: #BlDevScripterEventTarget>
	self 
		assert: [ self tasks isNotEmpty ]
		description: [ 'A subtask must be defined before accessing target' ].
	^ self tasks last target
]

{ #category : #accessing }
BlDevScripterCompositeTask >> target: aScripterEventTarget [
	self 
		assert: [ self tasks isNotEmpty ]
		description: [ 'A subtask must be defined before defining target' ].
	self tasks last target: aScripterEventTarget
]

{ #category : #accessing }
BlDevScripterCompositeTask >> tasks [
	^ tasks
]
