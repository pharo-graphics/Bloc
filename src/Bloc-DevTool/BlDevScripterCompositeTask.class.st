Class {
	#name : #BlDevScripterCompositeTask,
	#superclass : #BlDevScripterTask,
	#instVars : [
		'tasks'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #adding }
BlDevScripterCompositeTask >> addTask: aTask [
	tasks add: aTask.
	^ aTask
]

{ #category : #initialization }
BlDevScripterCompositeTask >> initialize [
	super initialize.
	
	tasks := OrderedCollection new
]

{ #category : #actions }
BlDevScripterCompositeTask >> playOn: aScripter [
	self tasks do: [ :eachTask | eachTask playOn: aScripter ]
]

{ #category : #accessing }
BlDevScripterCompositeTask >> tasks [
	^ tasks
]
