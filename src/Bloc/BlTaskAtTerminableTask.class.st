Class {
	#name : #BlTaskAtTerminableTask,
	#superclass : #BlTaskAtTask,
	#instVars : [
		'shouldTerminate',
		'wasExecuted',
		'mutex'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #initialization }
BlTaskAtTerminableTask >> initialize [
	super initialize.
	shouldTerminate := false.
	wasExecuted := false.
	mutex := Mutex new.
]

{ #category : #actions }
BlTaskAtTerminableTask >> terminate [
	mutex critical: [ 
		wasExecuted ifFalse: [ 
			shouldTerminate := true.
			^ self ] ].
	self valuable terminate.
]

{ #category : #evaluating }
BlTaskAtTerminableTask >> value [
	mutex critical: [ 
		shouldTerminate ifTrue: [ ^ nil ].
		wasExecuted := true ].
	^ super value
]
