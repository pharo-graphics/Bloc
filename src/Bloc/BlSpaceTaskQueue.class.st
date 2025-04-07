Class {
	#name : #BlSpaceTaskQueue,
	#superclass : #BlTaskQueue,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlSpaceTaskQueue class >> space: aBlSpace [

	^ self basicNew
		  initializeWith: aBlSpace;
		  yourself
]

{ #category : #initialization }
BlSpaceTaskQueue >> initializeWith: aBlSpace [

	self initialize.

	space := aBlSpace
]

{ #category : #private }
BlSpaceTaskQueue >> requeue: aBlTask [

	super requeue: aBlTask.
	aBlTask onEnqueued: space.
	space requestNextPulse
]
