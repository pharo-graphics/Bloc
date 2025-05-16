Class {
	#name : #BlEnqueuedCommand,
	#superclass : #Object,
	#instVars : [
		'command',
		'applier'
	],
	#category : #'Bloc-CommandApplier'
}

{ #category : #accessing }
BlEnqueuedCommand >> applier [

	^ applier
]

{ #category : #accessing }
BlEnqueuedCommand >> applier: anObject [

	applier := anObject
]

{ #category : #accessing }
BlEnqueuedCommand >> command [

	^ command
]

{ #category : #accessing }
BlEnqueuedCommand >> command: aCommand [

	command := aCommand
]
