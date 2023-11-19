"
BlDelayedTask delays its action until after the specified time by being scheduled on every pulse, but simply marking itself for requeue if the appointed time has not yet been reached.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	delay:		<Object>
	element:		<Object>
	isRunning:		<Object>
	requeue:		<Boolean>
	startTime:		<Object>
	time:		<Object>


### Implementation Points

The task state is currently not thread-safe, so the time between checking the task state and acting on it provides a window where another process could issue a conflicting instruction.  This hasn't been a problem so far, so is left open.

"
Class {
	#name : 'BlDelayedTask',
	#superclass : 'BlTask',
	#instVars : [
		'delay',
		'element',
		'time',
		'isRunning',
		'startTime',
		'requeue'
	],
	#category : 'Bloc-Space - Tasks',
	#package : 'Bloc',
	#tag : 'Space - Tasks'
}

{ #category : 'accessing' }
BlDelayedTask >> delay [
	<return: #Duration>

	^ delay
]

{ #category : 'accessing' }
BlDelayedTask >> delay: aDuration [
	delay := aDuration
]

{ #category : 'private' }
BlDelayedTask >> dequeue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be dequeued' ].

	self element dequeueTask: self
]

{ #category : 'accessing' }
BlDelayedTask >> element [
	<return: #BlElement>

	^ element
]

{ #category : 'accessing' }
BlDelayedTask >> element: aBlElement [
	element := aBlElement
]

{ #category : 'private' }
BlDelayedTask >> enqueue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be enqueued' ].

	self element enqueueTask: self
]

{ #category : 'initialization' }
BlDelayedTask >> initialize [
	super initialize.
	
	delay := 500 milliSeconds.
	time := BlTime real.
	isRunning := true.
	requeue := false.
]

{ #category : 'api - testing' }
BlDelayedTask >> isRunning [
	<return: #Boolean>

	^ isRunning
]

{ #category : 'hooks' }
BlDelayedTask >> onEnqueued: aBlSpace [
	super onEnqueued: aBlSpace.

	self time: aBlSpace time.
	
	"start time of the very first time when we are enqueued"
	startTime
		ifNil: [ startTime := self time now ]
]

{ #category : 'hooks' }
BlDelayedTask >> onEnqueuedInElement: aBlElement [
	self element: aBlElement
]

{ #category : 'api - running' }
BlDelayedTask >> onRun [
	"Override me to implement a custom action"
]

{ #category : 'private - testing' }
BlDelayedTask >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution."

	^ requeue
]

{ #category : 'api - running' }
BlDelayedTask >> run [
	self isRunning
		ifFalse: [ ^ self ].
	
	"time didn't come yet for me to run?"
	(requeue := self time now < (startTime + self delay)) 
		ifTrue: [ ^ self ].
	
	self onRun.
	self stop
]

{ #category : 'api - running' }
BlDelayedTask >> start [
	self
		assert: [ element isNotNil ]
		description: [ 'Task must be attached to the element' ].
	self
		assert: [ self isNew or: [ self isComplete ] ]
		description: 'Can''t start a queued task'.

	isRunning := true.
	startTime := self time now.
	self setNew.
	self enqueue
]

{ #category : 'api - running' }
BlDelayedTask >> startOrRestart [
	"Ensure that the receiver is running and enqueued.
	If already running, reset the start time (there is always the possibility that this will be called just after the task has started running, so will continue rather than waiting the full delay)."

	self
		assert: [ element isNotNil ]
		description: [ 'Task must be attached to the element' ].

	(self isNew or: [ self isComplete ]) ifTrue: 
		[ ^ self start ].

	startTime := self time now.

]

{ #category : 'api - running' }
BlDelayedTask >> stop [
	"Stop the task by dequeuing it"
	(element isNotNil and: [ self isRunning ])
		ifTrue: [ self dequeue ].

	isRunning := false.
	startTime := nil.
	requeue := false
]

{ #category : 'accessing' }
BlDelayedTask >> time [
	<return: #BlTime>

	^ time
]

{ #category : 'accessing' }
BlDelayedTask >> time: aBlTime [
	time := aBlTime
]
