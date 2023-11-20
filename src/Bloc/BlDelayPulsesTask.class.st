"
BlDelayPulsesTask executes itself after the specified number of pulses have been run. 

Public API and Key Messages

- count:   set the number of pulses to wait, default = 1.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	count:			<Integer> 	The number of pulses to wait.
	element:		<BlElement>	The element where the receiver was queued.
	requeue:		<Boolean>		A boolean indicating whether the task needs to be requeued (there are still pulses to wait through)


### Implementation Points

"
Class {
	#name : 'BlDelayPulsesTask',
	#superclass : 'BlTask',
	#instVars : [
		'element',
		'count',
		'requeue'
	],
	#category : 'Bloc-Space - Tasks',
	#package : 'Bloc',
	#tag : 'Space - Tasks'
}

{ #category : 'accessing' }
BlDelayPulsesTask >> count [
	^ count
]

{ #category : 'accessing' }
BlDelayPulsesTask >> count: anObject [
	count := anObject
]

{ #category : 'private' }
BlDelayPulsesTask >> dequeue [

	self element dequeueTask: self
]

{ #category : 'accessing' }
BlDelayPulsesTask >> element [
	<return: #BlElement>

	^ element
]

{ #category : 'accessing' }
BlDelayPulsesTask >> element: aBlElement [
	element := aBlElement
]

{ #category : 'private' }
BlDelayPulsesTask >> enqueue [

	self element enqueueTask: self
]

{ #category : 'initialization' }
BlDelayPulsesTask >> initialize [
	super initialize.
	
	count := 1.
	requeue := false.
]

{ #category : 'hooks' }
BlDelayPulsesTask >> onEnqueuedInElement: aBlElement [
	self element: aBlElement
]

{ #category : 'api - running' }
BlDelayPulsesTask >> onRun [
	"Override me to implement a custom action"
]

{ #category : 'private - testing' }
BlDelayPulsesTask >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution."

	^ requeue
]

{ #category : 'api - running' }
BlDelayPulsesTask >> run [

	"If count is greater than 0, decrement and requeue"
	count := count - 1.
	(requeue := count > 0) 
		ifTrue: [ ^ self ].

	self onRun.

]

{ #category : 'api - running' }
BlDelayPulsesTask >> start [
	self
		assert: [ element isNotNil ]
		description: [ 'Task must be attached to the element' ].
	self
		assert: [ self isNew or: [ self isComplete ] ]
		description: 'Can''t start a queued task'.

	self setNew.
	self enqueue
]

{ #category : 'api - running' }
BlDelayPulsesTask >> stop [
	"Stop the task by dequeuing it"
	self dequeue.

]
