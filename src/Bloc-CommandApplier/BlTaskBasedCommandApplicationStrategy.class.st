Class {
	#name : #BlTaskBasedCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#instVars : [
		'weak'
	],
	#category : #'Bloc-CommandApplier'
}

{ #category : #accessing }
BlTaskBasedCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aCommandApplier applyCommand: aCommand.
			^ self ] ].
	element enqueueTask:
		(BlTaskAction new action: [ aCommandApplier applyCommand: aCommand ])
]

{ #category : #initialization }
BlTaskBasedCommandApplicationStrategy >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #accessing }
BlTaskBasedCommandApplicationStrategy >> weak: anObject [

	weak := anObject
]
