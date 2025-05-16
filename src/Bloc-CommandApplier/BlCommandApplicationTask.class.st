Class {
	#name : #BlCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction',
		'posponedRequestTask',
		'element'
	],
	#category : #'Bloc-CommandApplier'
}

{ #category : #'api - running' }
BlCommandApplicationTask >> applyAll [

	element ifNil: [ ^ self ].
	self canApplyCommands ifFalse: [
		posponedRequestTask ifNotNil: [ ^ self ].
		posponedRequestTask := BlTaskAction new.
		posponedRequestTask action: [ self privateApplyAll ].
		element enqueueTask: posponedRequestTask.
		^ self ].

	self privateApplyAll
]

{ #category : #'api - running' }
BlCommandApplicationTask >> canApplyCommands [
	
	^ element notNil and: [ element isAttachedToSceneGraph ]
]

{ #category : #initialization }
BlCommandApplicationTask >> commandQueue: aQueue [
	
	commandQueue := aQueue
]

{ #category : #accessing }
BlCommandApplicationTask >> element: anElement [

	element := anElement
]

{ #category : #accessing }
BlCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #'api - running' }
BlCommandApplicationTask >> privateApplyAll [

	| nextInQueue |
	[ commandQueue isEmpty ] whileFalse: [
		nextInQueue := commandQueue removeFirst.
		nextInQueue applier applyCommand: nextInQueue command]
]

{ #category : #'api - running' }
BlCommandApplicationTask >> run [

	self applyAll.
	finishedAction value.
]
