Class {
	#name : #BlRepeatedTaskAction,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space-Support'
}

{ #category : #accessing }
BlRepeatedTaskAction >> action [
	^ action
]

{ #category : #accessing }
BlRepeatedTaskAction >> action: anObject [
	action := anObject
]

{ #category : #initialization }
BlRepeatedTaskAction >> initialize [
	super initialize.
	
	action := [  ]
]

{ #category : #'api - running' }
BlRepeatedTaskAction >> onRun [
	self action value
]
