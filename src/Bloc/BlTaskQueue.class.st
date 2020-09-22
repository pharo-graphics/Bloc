Class {
	#name : #BlTaskQueue,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'tasks',
		'lock'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #private }
BlTaskQueue >> critical: aBlock [
	^ lock critical: aBlock
]

{ #category : #'api - enqueue' }
BlTaskQueue >> dequeue: aBlTask [	
	"Remove the task from the queue.
	If complete, mark the task as new so it may be reused."

	self
		assert: [ aBlTask isNotNil ]
		description: [ 'Task must not be nil' ].

	tasks ifNotNil:
		[ lock critical: 
			[ (tasks includes: aBlTask) ifTrue: 
				[ tasks remove: aBlTask.
				aBlTask setNew ] ] ].
]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueue: aBlTask [
	| taskExists |

	self
		assert: [ aBlTask isNotNil ]
		description: [ 'Task must not be nil' ].

	"Tasks must be new.
	Tasks that are already complete could also be allowed, but requiring new tasks means that any state in the task should have also been reset"
	self
		assert: [ aBlTask isNew ]
		description: [ 'Tasks cannot be submitted twice' ].
	tasks ifNil: [ tasks := self newTasks ].

	lock critical: [
		taskExists := tasks includes: aBlTask.
		taskExists ifFalse:
			[ tasks add: aBlTask.
			aBlTask setQueued ] ].

	self
		assert: [ taskExists not ]
		description: [ 'Task must not exist' ].

]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueueAll: aCollectionOfBlTask [
	| taskExists |

	self
		assert: [ aCollectionOfBlTask isNotNil ]
		description: [ 'Tasks must not be nil' ].

	tasks ifNil: [ tasks := self newTasks ].
	lock critical: [
		taskExists := tasks includesAny: aCollectionOfBlTask.
		taskExists ifFalse:
			[ aCollectionOfBlTask do: [ :task | task setQueued ].
			tasks addAll: aCollectionOfBlTask ] ].

	self
		assert: [ taskExists not ]
		description: [ 'Tasks must not exist' ].

]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueueFrom: aBlTaskQueue [
	self
		assert: [ aBlTaskQueue isNotNil ]
		description: [ 'Queue to transfer must not be nil' ].

	aBlTaskQueue critical: [
		self enqueueAll: aBlTaskQueue tasks.
		aBlTaskQueue flush ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> flush [
	| theTasks |

	"Assignments without message sends are atomic, so no lock required"
	theTasks := tasks.
	tasks := nil.

	^ theTasks.

]

{ #category : #initialization }
BlTaskQueue >> initialize [
	super initialize.
	
	lock := Monitor new
]

{ #category : #'api - accessing' }
BlTaskQueue >> isEmpty [
	<return: #Boolean>

	^ lock critical: [ tasks isNil or: [ tasks isEmpty ] ]
]

{ #category : #private }
BlTaskQueue >> newTasks [
	"Answer a new collection for storing tasks"

	^ OrderedCollection new.
]

{ #category : #printing }
BlTaskQueue >> printOn: aStream [

	super printOn: aStream.
	tasks ifNotNil: 
		[ aStream
			nextPut: $(;
			print: tasks size;
			nextPut: $) ]
]

{ #category : #private }
BlTaskQueue >> requeue: aBlTask [
	"Requeue the supplied task"

	"This is only used internally as part of the task execution, thus the task's state should be executing"
	self
		assert: [ aBlTask isExecuting ]
		description: [ 'Tasks cannot be requeued outside execution' ].

	aBlTask setNew.
	self enqueue: aBlTask
]

{ #category : #'api - running' }
BlTaskQueue >> runOn: aSpace [
	| theTasks |
	
	lock critical: [
		"We store reference to tasks Array because it is possible
		that a random task is removed while enumerating a collection.
		This switch can be made atomic without the lock, but is here while state management is enabled."
		theTasks := tasks.
		tasks := nil.
		"Mark all tasks as pending"
		theTasks ifNotNil:
			[ theTasks do: [ :task | task setPendingExecution ] ] ].

	"since we have an immutable reference to original array, there is need to execute task within a lock"
	theTasks ifNotNil:
		[ theTasks do: [ :aTask |
			aTask setExecuting.
			aSpace telemetry
				timeSync: [ 'Run task {1} ({2})' format: { aTask class name . aTask } ]
				during: [ BlTaskExecutionSignal for: aTask block: [ aTask run ] ].
			aTask requeueTaskAfterExecution ifTrue: 
				[ self requeue: aTask ]
			ifFalse:
				[ aTask setComplete ] ] ].

]

{ #category : #'api - accessing' }
BlTaskQueue >> tasks [
	"Return a new collection instance holding all my tasks"

	tasks ifNil: [ ^ #() ].
	"tasks are an OrderedCollection (or nil), thus converting to anArray is guaranteed to answer a copy"
	^ lock critical: 
		[ tasks 
			ifNil: [ #() ]
			ifNotNil: [ tasks asArray ] ].

]
