"
I am a repeated task that evaluates a block each time.
"
Class {
	#name : #BlRepeatedTaskAction,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlRepeatedTaskAction >> action [

	^ action
]

{ #category : #accessing }
BlRepeatedTaskAction >> action: aBlock [

	action := aBlock
]

{ #category : #initialization }
BlRepeatedTaskAction >> initialize [

	super initialize.

	action := [ ]
]

{ #category : #'api - running' }
BlRepeatedTaskAction >> onRun [

	self action value
]
