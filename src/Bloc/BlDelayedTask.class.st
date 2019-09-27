Class {
	#name : #BlDelayedTask,
	#superclass : #BlTask,
	#instVars : [
		'delay',
		'element',
		'time',
		'isRunning',
		'startTime'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlDelayedTask >> delay [
	<return: #Duration>

	^ delay
]

{ #category : #accessing }
BlDelayedTask >> delay: aDuration [
	delay := aDuration
]

{ #category : #private }
BlDelayedTask >> dequeue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be dequeued' ].

	self element dequeueTask: self
]

{ #category : #accessing }
BlDelayedTask >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlDelayedTask >> element: aBlElement [
	element := aBlElement
]

{ #category : #private }
BlDelayedTask >> enqueue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be enqueued' ].

	self element enqueueTask: self
]

{ #category : #initialization }
BlDelayedTask >> initialize [
	super initialize.
	
	delay := 500 milliSeconds.
	time := BlTime real.
	isRunning := true
]

{ #category : #'api - testing' }
BlDelayedTask >> isRunning [
	<return: #Boolean>

	^ isRunning
]

{ #category : #hooks }
BlDelayedTask >> onEnqueued: aBlSpace [
	super onEnqueued: aBlSpace.

	self time: aBlSpace time.
	
	"start time of the very first time when we are enqueued"
	startTime
		ifNil: [ startTime := self time now ]
]

{ #category : #hooks }
BlDelayedTask >> onEnqueuedInElement: aBlElement [
	self element: aBlElement
]

{ #category : #'api - running' }
BlDelayedTask >> onRun [
	"Override me to implement a custom action"
]

{ #category : #'api - running' }
BlDelayedTask >> run [
	self isRunning
		ifFalse: [ ^ self ].
	
	"time didn't come yet for me to run"
	(self time now < (startTime + self delay))
		ifTrue: [ ^ self enqueue ].
	
	self onRun.
	self stop
]

{ #category : #'api - running' }
BlDelayedTask >> start [
	self
		assert: [ element isNotNil ]
		description: [ 'Task must be attached to the element' ].

	isRunning := true.
	startTime := self time now.
	element ifNotNil: [ self dequeue ].
	self enqueue
]

{ #category : #'api - running' }
BlDelayedTask >> stop [
	"Stop the task by dequeuing it"
	(element isNotNil and: [ self isRunning ])
		ifTrue: [ self dequeue ].

	isRunning := false.
	startTime := nil
]

{ #category : #accessing }
BlDelayedTask >> time [
	<return: #BlTime>

	^ time
]

{ #category : #accessing }
BlDelayedTask >> time: aBlTime [
	time := aBlTime
]
