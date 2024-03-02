"
I represent a task that runs until stop is sent, waiting between runs by the duration specified as delay.
"
Class {
	#name : #BlRepeatedTask,
	#superclass : #BlTask,
	#instVars : [
		'delay',
		'element',
		'time',
		'previousRunTime',
		'isRunning'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlRepeatedTask >> delay [

	^ delay
]

{ #category : #accessing }
BlRepeatedTask >> delay: aDuration [

	delay := aDuration
]

{ #category : #private }
BlRepeatedTask >> dequeue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be dequeued' ].

	self element dequeueTask: self
]

{ #category : #accessing }
BlRepeatedTask >> element [

	^ element
]

{ #category : #accessing }
BlRepeatedTask >> element: aBlElement [

	element := aBlElement
]

{ #category : #private }
BlRepeatedTask >> enqueue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be enqueued' ].

	self element enqueueTask: self
]

{ #category : #initialization }
BlRepeatedTask >> initialize [

	super initialize.
	
	delay := 500 milliSeconds.
	time := BlTime real.
	isRunning := true
]

{ #category : #'api - testing' }
BlRepeatedTask >> isRunning [

	^ isRunning
]

{ #category : #hooks }
BlRepeatedTask >> onEnqueued: aBlSpace [

	super onEnqueued: aBlSpace.

	self time: aBlSpace time
]

{ #category : #hooks }
BlRepeatedTask >> onEnqueuedInElement: aBlElement [

	self element: aBlElement
]

{ #category : #'api - running' }
BlRepeatedTask >> onRun [
	"Override me to implement a custom action"
]

{ #category : #'private - testing' }
BlRepeatedTask >> requeueTaskAfterExecution [

	^ isRunning
]

{ #category : #'api - running' }
BlRepeatedTask >> run [

	| now |
	isRunning ifFalse: [ ^ self ].

	now := time now.
	(previousRunTime isNotNil and: [ now < (previousRunTime + delay) ])
		ifTrue: [ ^ self ].

	previousRunTime := now.
	self onRun
]

{ #category : #'api - running' }
BlRepeatedTask >> stop [

	isRunning := false
]

{ #category : #accessing }
BlRepeatedTask >> time [

	^ time
]

{ #category : #accessing }
BlRepeatedTask >> time: aBlTime [

	time := aBlTime
]
