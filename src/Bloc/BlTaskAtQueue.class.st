"
BlTaskAtQueue provides a reasonably efficient mechanism to scheduled tasks to be executed at a specified time.

The queue executes tasks within a single pharo process at #userSchedulingPriority, so tasks should be kept as short as possible, typically queueing the task up at a more appropriate place, e.g. one of the TaskIt background queues or within the UI process.


!!Public API and Key Messages

- start : 	Start the reader process 
- stop : 		Stop the reader process
- schedule:at: 	Schedule the supplied valuable to be executed at the specified time

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	executorProcess:		<Process>
	queue:						<SharedPriorityUniqueQueue>
	scheduleSemaphore:		<Semaphore>


!!!Implementation Points

- Assumes that there is only one reader of the queue.
"
Class {
	#name : #BlTaskAtQueue,
	#superclass : #Object,
	#instVars : [
		'queue',
		'scheduleSemaphore',
		'executorProcess',
		'nextTime'
	],
	#classVars : [
		'Default'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlTaskAtQueue class >> default [ 

	^Default ifNil: [ Default := self new start ]
]

{ #category : #private }
BlTaskAtQueue >> forkExecutorProcess [

	self
		assert: executorProcess isNil 
		description: 'Only one executor process is allowed'.
	executorProcess := [ self queueReaderLoop ]
		forkAt: Processor userSchedulingPriority 
		named: 'BlTaskAtQueue Executor'.
]

{ #category : #initialization }
BlTaskAtQueue >> initialize [

	super initialize.
	queue := SharedPriorityUniqueQueue new.
	scheduleSemaphore := Semaphore new.

]

{ #category : #private }
BlTaskAtQueue >> next [
	"Answer the next item from the receiver's queue.
	For testing purposes only."

	^queue next
]

{ #category : #private }
BlTaskAtQueue >> processNextEntry [

	| entry timeRemaining |

	scheduleSemaphore wait.
	[ entry := queue peek.
	entry isNotNil and: [ 
		timeRemaining := entry scheduledTime - BlTime real now.
		timeRemaining < 10 milliSeconds ] ] whileTrue: [ 
		entry := queue next.
		[ entry value ]
			on: Error 
			do: [ :ex | BlTaskAtErrorSignal new 
								exception: ex;
								task: entry;
								message: 'Entry execution exception - continuing';
								emit ] ].
	entry := queue peek.
	entry 
		ifNil: [ nextTime := nil ]
		ifNotNil: [ self triggerAt: entry scheduledTime ].

]

{ #category : #private }
BlTaskAtQueue >> queueReaderLoop [

	[ [ self processNextEntry ]
		on: Error 
		do: [ :ex | BlTaskAtErrorSignal new 
								exception: ex;
								message: 'Reader loop exception - restarting';
								emit.
					(Delay forSeconds: 5) wait. ] ] repeat.
]

{ #category : #operations }
BlTaskAtQueue >> schedule: aBlTaskAtTask [
	"Add the supplied task to the queue and trigger the semaphore at the appropriate time.
	Return the scheduled task or a similar previously scheduled task."

	| aResult |
	aResult := queue nextPut: aBlTaskAtTask.
	aResult == aBlTaskAtTask  ifFalse: [ 
		aBlTaskAtTask handleNotScheduledBecauseOfPreviousTask: aResult.
		^ aResult ].
	
	(nextTime isNil or: [ aBlTaskAtTask scheduledTime < nextTime ])
		ifTrue: [ self triggerAt: aBlTaskAtTask scheduledTime ].
	^ aBlTaskAtTask.
]

{ #category : #operations }
BlTaskAtQueue >> schedule: aValuable at: aTime [
	"Add the supplied task to the queue and trigger the semaphore at the appropriate time"

	self schedule: (BlTaskAtTask valuable: aValuable at: aTime)
]

{ #category : #control }
BlTaskAtQueue >> start [ 

	self forkExecutorProcess.
]

{ #category : #control }
BlTaskAtQueue >> stop [ 

	executorProcess ifNil: [ ^self ].
	executorProcess terminate.
	executorProcess := nil.
]

{ #category : #private }
BlTaskAtQueue >> triggerAfter: aDelay [

	self
		assert: [ aDelay isKindOf: Duration ]
		description: [ 'Delay must be a duration' ].

	[	aDelay wait.
		scheduleSemaphore signal ]
			forkAt: Processor userSchedulingPriority
			named: 'BlTaskAt: ', aDelay asMilliSeconds asString
]

{ #category : #private }
BlTaskAtQueue >> triggerAt: aTime [
	"Signal the scheduleSemaphore at the requested time"
	| durationUntilRequestedTime |

	durationUntilRequestedTime := aTime - BlTime real now.
	durationUntilRequestedTime < 10 milliSeconds
		ifTrue: [ scheduleSemaphore signal ]
		ifFalse: [ 
			nextTime := aTime.
			self triggerAfter: durationUntilRequestedTime ]
]
