"
! Bloc-TaskIt Process Guidelines

Building responsive applications require dealing with processes responsible for long-time computation and giving back to an user interface an answer, when it is ready. 

Applications can therefore end-up with many processes. In addition, those processes can spawn sub-processes. Check the following example (look at the scrollbar):
+Process Browser with many processes>file://feenkcom/Bloc/doc/class-comment-support/process-inflation-issue.png+ 

To manage and deal with such information, we need to keep a control of it. For example, developers should understand the process hierarchy and which graphical widget (application) spawned what process.

!! Considerations

- Processes should be created in unified way, a common API.
- We should have tools to deal with possible process issues, e.g., too many processes running in the background.
- ${class:BlTaskItStatus}$ to be live (a few more views).
- Submitted tasks could have a name (and maybe a source).
- ${class:BlTaskItStatus}$ could then provide a view showing the currently executing tasks (by name (and source))
- TaskIt also has a process viewer, but I've never been able to make sense of it.  (It's not loaded by default)
- It would also be good to have an overview of all the tasks queued against ${class:BlElement}$ instances and ${class:BlSpace}$. 
 
 
!! Common API
 
 
"
Class {
	#name : #BlTaskItGuidelines,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'collection',
		'semaphore'
	],
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'examples - actions' }
BlTaskItGuidelines >> addToCollection: anObject [
	mutex critical: [ collection add: anObject ]
]

{ #category : #'examples - basic (non public api)' }
BlTaskItGuidelines >> asyncUIWorkerPoolWithOneWorker [
	<gtExample>
	"Notice that sending #new is not a public API. Check the class comment for more information."
	| aWorkerPool |
	aWorkerPool := self basicAsyncUIWorkerPool.
	aWorkerPool poolMaxSize: 1.
	self assert: aWorkerPool poolMaxSize equals: 1.
	self assert: aWorkerPool size equals: 0. "It has NOT a worker"
	self assert: aWorkerPool taskQueue size equals: 0. "It has NOT a task"
	self assert: aWorkerPool isFree. "There is NOT a waiting task"
	^ aWorkerPool
]

{ #category : #'examples - basic (non public api)' }
BlTaskItGuidelines >> basicAsyncUIWorkerPool [
	<gtExample>
	"Notice that sending #new is not a public API. Check the class comment for more information."
	| aWorkerPool |
	aWorkerPool := BlAsyncUIWorkerPool new.
	self assert: aWorkerPool isNotNil.
	self assert: (aWorkerPool name beginsWith: 'AsyncElementWorker').
	self assert: aWorkerPool poolMaxSize equals: aWorkerPool class defaultPoolSize.
	self assert: aWorkerPool size equals: 0. "It has NOT a worker"
	self assert: aWorkerPool taskQueue size equals: 0. "It has NOT a task"
	self assert: aWorkerPool isFree. "There is NOT a waiting task"
	^ aWorkerPool
]

{ #category : #'examples - actions' }
BlTaskItGuidelines >> incrementCounter [
	<gtExample>
	| aNewValue |
	mutex critical: [ 
		aNewValue := collection size + 1.
		collection add: aNewValue.
		self assert: collection size equals: aNewValue.
		self assert: collection last equals: aNewValue ].
	^ aNewValue
	
]

{ #category : #'examples - actions' }
BlTaskItGuidelines >> incrementCounterTwice [
	<gtExample>
	| aValue |
	self incrementCounter.
	aValue := self incrementCounter.
	self assert: aValue equals: 2.
	^ aValue
	
]

{ #category : #'examples - basic (non public api)' }
BlTaskItGuidelines >> incrementalCounterTask [
	<gtExample>
	| aTask |
	aTask := [ self incrementCounter ] asTask.
	self assert: aTask isNotNil.
	self assert: (aTask isKindOf: TKTTask).
	^ aTask 
]

{ #category : #'examples - basic (non public api)' }
BlTaskItGuidelines >> incrementalCounterTaskName [
	<gtExample>
	^ 'Counter++'
]

{ #category : #initialization }
BlTaskItGuidelines >> initialize [
	super initialize.
	collection := OrderedCollection new.
	mutex := Mutex new.
	semaphore := Semaphore new.
]

{ #category : #'examples - schedule' }
BlTaskItGuidelines >> scheduleCounterTaskAsAsyncUI [
	<gtExample>
	| aWorkerPool aTask aNamedTask |
	aWorkerPool := self asyncUIWorkerPoolWithOneWorker.
	aTask := self incrementalCounterTask.
	aNamedTask := aWorkerPool schedule: aTask named: self incrementalCounterTaskName.
	"Task configuration"
	self assert: aTask ~= aNamedTask.
	self assert: aNamedTask task equals: aTask.
	self assert: aNamedTask name equals: self incrementalCounterTaskName.
	"WorkerPool configuration"
	self assert: aWorkerPool size equals: 1. "It has one worker"
	self assert: aWorkerPool taskQueue size equals: 1. "It has one task"
	self assert: aWorkerPool isFree not. "There is a waiting task"
	self assert: collection size equals: 0.
	^ aWorkerPool
]

{ #category : #'examples - schedule' }
BlTaskItGuidelines >> scheduleTaskThatSchedulesAnotherTask [
	<gtExample>
	| aWorkerPool aRootTask aSubTask |
	aWorkerPool := self asyncUIWorkerPoolWithOneWorker.
	aSubTask := aRootTask := nil.
	aSubTask := [ self addToCollection: aSubTask. self signalSemaphore. ] asTask asNamedTask.
	aSubTask name: 'I am an example subtask'.
	aRootTask := [ 
			self addToCollection: aRootTask. 
			aWorkerPool schedule: aSubTask. 
			self addToCollection: aRootTask.
			self signalSemaphore ] asTask asNamedTask.
	aRootTask name: 'I am an example root task'.
	aWorkerPool schedule: aRootTask.
	self waitForSemaphoreSignal.
	self waitForSemaphoreSignal.
	"WorkerPool configuration"
	self assert: aWorkerPool size equals: 1. "It has one worker"
	self assert: aWorkerPool taskQueue size equals: 0. "It has NOT a task"
	self assert: aWorkerPool isFree. "There is NOT a waiting task"
	"Check that tasks were executed"
	self assert: collection size equals: 3.
	self assert: collection first equals: aRootTask.
	self assert: collection second equals: aRootTask.
	self assert: collection third equals: aSubTask.
	^ aWorkerPool
]

{ #category : #'examples - actions' }
BlTaskItGuidelines >> signalSemaphore [
	^ semaphore signal
]

{ #category : #'examples - actions' }
BlTaskItGuidelines >> signalSemaphoreAction [
	^ [ self signalSemaphore ]
]

{ #category : #'examples - schedule' }
BlTaskItGuidelines >> waitForScheduleCounterTaskAsAsyncUI [
	<gtExample>
	| aWorkerPool |
	aWorkerPool := self scheduleCounterTaskAsAsyncUI.
	aWorkerPool schedule: self signalSemaphoreAction.
	self waitForSemaphoreSignal.
	"WorkerPool configuration"
	self assert: aWorkerPool size equals: 1. "It has one worker"
	self assert: aWorkerPool taskQueue size equals: 0. "It has NOT a task"
	self assert: aWorkerPool isFree. "There is NOT a waiting task"
	self assert: collection size equals: 1.
	^ aWorkerPool
]

{ #category : #'examples - actions' }
BlTaskItGuidelines >> waitForSemaphoreSignal [
	| aTimeout |
	aTimeout := semaphore waitTimeoutSeconds: 3.
	self assert: aTimeout not.
	^ aTimeout
]

{ #category : #'examples - actions' }
BlTaskItGuidelines >> waitingIncrementCounter [
	5 seconds wait.
	^ self incrementCounter.
	
]

{ #category : #'examples - basic (non public api)' }
BlTaskItGuidelines >> waitingIncrementalCounterTask [
	<gtExample>
	| aTask |
	aTask := [ self waitingIncrementCounter ] asTask.
	self assert: aTask isNotNil.
	self assert: (aTask isKindOf: TKTTask).
	^ aTask 
]
