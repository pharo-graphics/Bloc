Class {
	#name : #BlQueueBasedCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#instVars : [
		'commandQueue',
		'applicationTask',
		'queued',
		'weak'
	],
	#category : #'Bloc-CommandApplier'
}

{ #category : #accessing }
BlQueueBasedCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aCommandApplier applyCommand: aCommand.
			^ self ] ].

	commandQueue add: (BlEnqueuedCommand new
			 command: aCommand;
			 applier: aCommandApplier;
			 yourself).
	self postApplicationTask
]

{ #category : #accessing }
BlQueueBasedCommandApplicationStrategy >> element: anElement [

	super element: anElement.
	commandQueue := OrderedCollection new.
	applicationTask := self newCommandApplicationTask
		                   element: anElement;
		                   commandQueue: commandQueue;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
]

{ #category : #initialization }
BlQueueBasedCommandApplicationStrategy >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #accessing }
BlQueueBasedCommandApplicationStrategy >> newCommandApplicationTask [ 

	^ BlCommandApplicationTask new
]

{ #category : #'event handling' }
BlQueueBasedCommandApplicationStrategy >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]

{ #category : #accessing }
BlQueueBasedCommandApplicationStrategy >> weak: aBoolean [

	weak := aBoolean
]
