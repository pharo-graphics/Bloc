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

	tasks ifNotNil:
		[ self critical: 
			[ (tasks includes: aBlTask) ifTrue: 
				[ tasks remove: aBlTask.
				aBlTask setNew ] ] ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueue: aBlTask [

	| taskExists |

	"Tasks must be new.
	Tasks that are already complete could also be allowed, but requiring new tasks means that any state in the task should have also been reset"
	self
		assert: [ aBlTask isNew ]
		description: [ 'Tasks cannot be submitted twice' ].

	self critical: [
		tasks ifNil: [ tasks := self newTasks ].
		taskExists := tasks includes: aBlTask.
		taskExists ifFalse:
			[ tasks add: aBlTask.
			aBlTask setQueued ] ].

	self
		assert: [ taskExists not ]
		description: [ 'Task must not exist' ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueueAll: aCollectionOfBlTask [

	| taskExists |

	self critical: [
		tasks ifNil: [ tasks := self newTasks ].
		taskExists := tasks includesAny: aCollectionOfBlTask.
		taskExists ifFalse:
			[ aCollectionOfBlTask do: [ :task | task setQueued ].
			tasks addAll: aCollectionOfBlTask ] ].

	self
		assert: [ taskExists not ]
		description: [ 'Tasks must not exist' ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> enqueueFrom: aBlTaskQueue [
	"Transfer a queue."

	aBlTaskQueue critical: [
		self enqueueAll: aBlTaskQueue tasks.
		aBlTaskQueue flush ]
]

{ #category : #'api - enqueue' }
BlTaskQueue >> flush [

	| theTasks |
	"While assignments without message sends are atomic, so the sequence can't be interrupted, it's possible that a process switch would clear the tasks while another process is within the lock, so take the lock out here."
	self critical: [
		theTasks := tasks.
		tasks := nil ].

	^ theTasks
]

{ #category : #initialization }
BlTaskQueue >> initialize [

	super initialize.

	lock := Monitor new
]

{ #category : #'api - accessing' }
BlTaskQueue >> isEmpty [

	^ self critical: [ tasks isNil or: [ tasks isEmpty ] ]
]

{ #category : #private }
BlTaskQueue >> newTasks [
	"Answer a new collection for storing tasks"

	^ OrderedCollection new
]

{ #category : #printing }
BlTaskQueue >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self size;
		nextPut: $)
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
	self critical: [ "We store reference to the tasks Array because it is possible
		that a random task is removed while enumerating a collection.
		This switch can be made atomic without the lock, but is here since
		the tasks shouldn't be updated while another process has the lock."
		theTasks := tasks.
		tasks := nil.
		"Mark all tasks as pending"
		theTasks ifNotNil: [
			theTasks do: [ :task | task setPendingExecution ] ].

		"Since we have an immutable reference to original array, there is
		need to execute task within a lock."
		theTasks ifNotNil: [
			theTasks do: [ :aTask |
				(aTask
					 setExecuting;
					 run;
					 requeueTaskAfterExecution)
					ifTrue: [ self requeue: aTask ]
					ifFalse: [ aTask setComplete ] ] ] ]
]

{ #category : #accessing }
BlTaskQueue >> size [

	tasks ifNil: [ ^ 0 ].
	^ self critical: [ tasks ifNil: [ 0 ] ifNotNil: [ tasks size ] ]
]

{ #category : #'api - accessing' }
BlTaskQueue >> tasks [
	"Return a new collection instance holding all my tasks"

	tasks ifNil: [ ^ #(  ) ].

	"tasks are an OrderedCollection (or nil), thus converting to anArray is guaranteed to answer a copy"
	^ self critical: [
		  tasks ifNil: [ #(  ) ] ifNotNil: [ tasks asArray ] ]
]
