Class {
	#name : 'BlDelayedTaskAction',
	#superclass : 'BlDelayedTask',
	#instVars : [
		'action'
	],
	#package : 'Bloc',
	#tag : 'Space - Tasks'
}

{ #category : 'accessing' }
BlDelayedTaskAction >> action [
	^ action
]

{ #category : 'accessing' }
BlDelayedTaskAction >> action: aBlock [
	action := aBlock
]

{ #category : 'initialization' }
BlDelayedTaskAction >> initialize [
	super initialize.
	
	action := [ :optionalThisTask | ]
]

{ #category : 'api - running' }
BlDelayedTaskAction >> onRun [
	self action isClosure
		ifTrue: [ self action cull: self ]
		ifFalse: [ self action value ]
]
