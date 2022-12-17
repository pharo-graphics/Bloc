Class {
	#name : #BlDelayedPulsesTaskAction,
	#superclass : #BlDelayPulsesTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlDelayedPulsesTaskAction >> action [
	^ action
]

{ #category : #accessing }
BlDelayedPulsesTaskAction >> action: aBlock [
	action := aBlock
]

{ #category : #initialization }
BlDelayedPulsesTaskAction >> initialize [
	super initialize.
	
	action := [ :optionalThisTask | ]
]

{ #category : #'api - running' }
BlDelayedPulsesTaskAction >> onRun [
	self action isClosure
		ifTrue: [ self action cull: self ]
		ifFalse: [ self action value ]
]
