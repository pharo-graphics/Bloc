Class {
	#name : #BlDevScripterCompositeTask,
	#superclass : #BlDevScripterTask,
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
BlDevScripterCompositeTask >> tasks [
	^ tasks
]
