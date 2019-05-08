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
	#category : #'Bloc-Space-Support'
}

{ #category : #accessing }
BlRepeatedTask >> delay [
	<return: #Duration>

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
	<return: #BlElement>

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
	<return: #Boolean>

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

{ #category : #'api - running' }
BlRepeatedTask >> run [

	self isRunning
		ifFalse: [ ^ self ].

	"time didn't come yet for me to run"
	(previousRunTime isNotNil and: [ self time now < (previousRunTime + self delay) ])
		ifTrue: [ ^ self enqueue ].
	
	self onRun.
	previousRunTime := previousRunTime
		ifNil: [ self time now ]
		ifNotNil: [ previousRunTime + self delay ].
	
	"it is possible that we stop the task in #onRun"
	self isRunning
		ifTrue: [ self enqueue ]
]

{ #category : #'api - running' }
BlRepeatedTask >> stop [
	isRunning := false
]

{ #category : #accessing }
BlRepeatedTask >> time [
	<return: #BlTime>

	^ time
]

{ #category : #accessing }
BlRepeatedTask >> time: aBlTime [
	time := aBlTime
]
