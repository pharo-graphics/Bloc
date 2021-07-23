"
Enhancement: a repeated task should re-enqueue itself with its element when that element is removed from the scene graph. See <https://github.com/feenkcom/gtoolkit/issues/1840>.
See the {{gtMethod:name=BlRepeatedTask>>#run}} method.


"
Class {
	#name : 'BlRepeatedTask',
	#superclass : 'BlTask',
	#instVars : [
		'delay',
		'element',
		'time',
		'previousRunTime',
		'isRunning'
	],
	#category : 'Bloc-Space - Tasks'
}

{ #category : 'accessing' }
BlRepeatedTask >> delay [
	<return: #Duration>

	^ delay
]

{ #category : 'accessing' }
BlRepeatedTask >> delay: aDuration [
	delay := aDuration
]

{ #category : 'private' }
BlRepeatedTask >> dequeue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be dequeued' ].

	self element dequeueTask: self
]

{ #category : 'accessing' }
BlRepeatedTask >> element [
	<return: #BlElement>

	^ element
]

{ #category : 'accessing' }
BlRepeatedTask >> element: aBlElement [
	element := aBlElement
]

{ #category : 'private' }
BlRepeatedTask >> enqueue [

	self
		assert: [ self isRunning ]
		description: [ 'I must be running to be enqueued' ].

	self element enqueueTask: self
]

{ #category : 'initialization' }
BlRepeatedTask >> initialize [
	super initialize.
	
	delay := 500 milliSeconds.
	time := BlTime real.
	isRunning := true
]

{ #category : 'api - testing' }
BlRepeatedTask >> isRunning [
	<return: #Boolean>

	^ isRunning
]

{ #category : 'hooks' }
BlRepeatedTask >> onEnqueued: aBlSpace [
	super onEnqueued: aBlSpace.
	
	self time: aBlSpace time
]

{ #category : 'hooks' }
BlRepeatedTask >> onEnqueuedInElement: aBlElement [
	self element: aBlElement
]

{ #category : 'api - running' }
BlRepeatedTask >> onRun [
	"Override me to implement a custom action"
]

{ #category : 'api - running' }
BlRepeatedTask >> run [
	"Enhancement: a repeated task should re-enqueue itself with 
	its element when that element is removed from the scene graph. 
	See *https://github.com/feenkcom/gtoolkit/issues/1840*."

	(self isRunning and: [ self element isAttachedToSceneGraph  ])
		ifFalse: [ self stop. ^ self ].

	BlTaskAtQueue default 
		schedule: [ self element enqueueTask: 
				(BlTaskAction new action: [ self onRun; run ]) ]
		at: self time now + self delay
]

{ #category : 'api - running' }
BlRepeatedTask >> stop [
	isRunning := false
]

{ #category : 'accessing' }
BlRepeatedTask >> time [
	<return: #BlTime>

	^ time
]

{ #category : 'accessing' }
BlRepeatedTask >> time: aBlTime [
	time := aBlTime
]
