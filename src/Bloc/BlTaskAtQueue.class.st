"
BlTaskAtQueue provides a reasonably efficient mechanism to scheduled tasks to be executed at a specified time.

The queue executes tasks within a single pharo process at #userSchedulingPriority, so tasks should be kept as short as possible, typically queueing the task up at a more appropriate place, e.g. one of the TaskIt background queues or within the UI process.


## Public API and Key Messages

- start : 	Start the reader process 
- stop : 		Stop the reader process
- schedule:at: 	Schedule the supplied valuable to be executed at the specified time

 
## Internal Representation and Key Implementation Points.

### Instance Variables

	executorProcess:		<Process>
	queue:						<SharedPriorityUniqueQueue>
	scheduleSemaphore:		<Semaphore>
	processTime: 			<DateAndTime>


### Implementation Points

- Assumes that there is only one reader of the queue.
- processTime holds the current DateAndTime for the evaluation cycle.  Since {{gtClass:name=BlTaskAtQueueTask}}s use the time to calculate their entry priority this significantly reduces the number of times that the VM is called to retrieve the time.

"
Class {
	#name : #BlTaskAtQueue,
	#superclass : #Object,
	#instVars : [
		'queue',
		'scheduleSemaphore',
		'executorProcess',
		'nextTimeDelay',
		'cutoffDuration',
		'clock',
		'processTime'
	],
	#classVars : [
		'Default'
	],
	#category : #'Bloc-DataStructure - Priority Queue'
}

{ #category : #accessing }
BlTaskAtQueue class >> default [ 

	^Default ifNil: [ Default := self new start ]
]

{ #category : #accessing }
BlTaskAtQueue >> clock [
	"Answer the clock used to schedule the receiver"
	<return: #BlTime>

	^ clock
]

{ #category : #'private - accessing' }
BlTaskAtQueue >> clock: aBlTime [
	"Set the clock used to schedule the receiver.
	This is normally only changed for testing purposes."

	clock := aBlTime
]

{ #category : #accessing }
BlTaskAtQueue >> cutoffDuration [
	"Answer the duration used to determine whether to execute a task.
	I.e. tasks scheduled for less than cutoffDuration from now are run."
	<return: #Duration>

	^ cutoffDuration
]

{ #category : #accessing }
BlTaskAtQueue >> cutoffDuration: anObject [
	cutoffDuration := anObject
]

{ #category : #private }
BlTaskAtQueue >> forceProcess [
	"Force #processNextEntry to scan the queue.
	For testing purposes"

	scheduleSemaphore signal.
]

{ #category : #private }
BlTaskAtQueue >> forkExecutorProcess [

	self
		assert: [ executorProcess isNil ]
		description: [ 'Only one executor process is allowed' ].

	executorProcess := [ self queueReaderLoop ]
		forkAt: Processor userSchedulingPriority 
		named: 'BlTaskAtQueue Executor'.
]

{ #category : #initialization }
BlTaskAtQueue >> initialize [

	super initialize.
	queue := SharedPriorityUniqueQueue new.
	scheduleSemaphore := Semaphore new.
	cutoffDuration := 10 milliSeconds.
	nextTimeDelay := 15 seconds.
	clock := BlTime real.
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

	scheduleSemaphore waitTimeoutMSecs: nextTimeDelay asMilliSeconds .
	processTime := clock now.
	[ entry := queue peek.
	entry isNotNil and: [ 
		timeRemaining := entry scheduledTime - processTime.
		timeRemaining < cutoffDuration ] ] whileTrue: [ 
		entry := queue next.
		[ [ entry value ]
			on: Error 
			do: [ :ex |				
				BlTaskAtErrorSignal new 
					exception: ex;
					task: entry;
					message: 'Entry execution exception - continuing';
					emit ] ]
			on: Exception
			fork: [ :anException | anException pass ].
		processTime := clock now ].
	entry := queue peek.
	nextTimeDelay := entry 
		ifNil: [ 1 hour ]
		ifNotNil: [ entry scheduledTime - clock now ]
]

{ #category : #accessing }
BlTaskAtQueue >> processTime [
	"Answer the time that should be used for determining task priority and whether the task should be run now"
	<return: #DateAndTime>

	^ processTime
]

{ #category : #'private - accessing' }
BlTaskAtQueue >> processTime: aDateAndTime [
	"Set the time for processing the current entry.
	This is only used for testing."

	processTime := aDateAndTime.
]

{ #category : #private }
BlTaskAtQueue >> queueReaderLoop [

	[
		[
			[ self processNextEntry ]
				on: Error 
				do: [ :anError |
					BlTaskAtErrorSignal new 
						exception: anError;
						message: 'Reader loop error - restarting';
						emit.
					(Delay forSeconds: 5) wait ]
		]
		on: Exception
		fork: [ :anException | anException pass ]

	] repeat
]

{ #category : #operations }
BlTaskAtQueue >> schedule: aBlTaskAtTask [
	"Add the supplied task to the queue and trigger the semaphore (which will either run the task immediately, or update the timeout, if required).
	Return the scheduled task or a similar previously scheduled task."
	| aResult |

	aBlTaskAtTask queue: self.
	aResult := queue nextPut: aBlTaskAtTask.
	aResult == aBlTaskAtTask ifFalse: [ 
		aBlTaskAtTask handleNotScheduledBecauseOfPreviousTask: aResult.
		^ aResult ].
	scheduleSemaphore signal.
	^ aBlTaskAtTask.
]

{ #category : #operations }
BlTaskAtQueue >> schedule: aValuable at: aTime [
	"Add the supplied task to the queue and trigger the semaphore at the appropriate time"

	self schedule: (BlTaskAtQueueTask valuable: aValuable at: aTime)
]

{ #category : #accessing }
BlTaskAtQueue >> size [

	^ queue size
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
