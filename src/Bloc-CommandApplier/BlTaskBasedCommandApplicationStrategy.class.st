Class {
	#name : #BlTaskBasedCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#instVars : [
		'weak',
		'enqueuedCount'
	],
	#category : #'Bloc-CommandApplier'
}

{ #category : #accessing }
BlTaskBasedCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	weak ifTrue: [
			element isAttachedToSceneGraph ifFalse: [
					aCommandApplier applyCommand: aCommand.
					^ self ] ].
	enqueuedCount := enqueuedCount + 1.
	element enqueueTask: (BlTaskAction new action: [
				 aCommandApplier applyCommand: aCommand.
				 enqueuedCount := enqueuedCount - 1 ])
]

{ #category : #testing }
BlTaskBasedCommandApplicationStrategy >> hasPendingCommands [ 

	^ enqueuedCount > 0
]

{ #category : #initialization }
BlTaskBasedCommandApplicationStrategy >> initialize [ 

	super initialize.
	weak := true.
	enqueuedCount := 0
]

{ #category : #accessing }
BlTaskBasedCommandApplicationStrategy >> weak: anObject [

	weak := anObject
]
