Class {
	#name : #BlRepeatedTaskAction,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'action'
	],
	#category : 'Bloc-Space - Tasks'
}

{ #category : 'accessing' }
BlRepeatedTaskAction >> action [
	^ action
]

{ #category : 'accessing' }
BlRepeatedTaskAction >> action: aBlock [
	action := aBlock
]

{ #category : 'initialization' }
BlRepeatedTaskAction >> initialize [
	super initialize.
	
	action := [ :optionalThisTask | ]
]

{ #category : 'api - running' }
BlRepeatedTaskAction >> onRun [
	self action isClosure
		ifTrue: [ self action cull: self ]
		ifFalse: [ self action value ]
]
