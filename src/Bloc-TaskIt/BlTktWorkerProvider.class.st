"
BlTktWorkerProvider provides a number of convenience methods for submitting tasks at different priorities.  The intention is that the supplied set of queues will be sufficient when submitting tasks in all cases but a few exceptions.

The main UI processing process runs at priority 40 (${method:name=ProcessorScheduler>>#userSchedulingPriority} (39 during development).  The design goal is to be keep the UI responsive by reducing the work done by the UI process to responding to user input and any other processing that is restricted to the UI process for thread safety reasons.

The supported worker pools and their expected uses are:

;#highUICPUBoundPool
:This is used for background rendering of views where the processing time is reasonably short and the process is CPU constrained.
;#highUIExternalResourceBoundPool
:This is used for background rendering of views where the process is expected to spend significant time waiting on external resources, e.g. retrieving a file over the network.
;#lowUIUserExecutionPool
:This is used for background processing where the execution time may be arbitrary, e.g. evaluation of user code in a playground.
;#nonUISinglePool
:This is used for background processing that won't be directly used by the user, e.g. cache management, and only a single instance should be run at a time.
;#nonUIMultiPool
:This is used for background processing that won't be directly used by the user and multiple instances may be run concurrently.

For detailed pool configuration information, e.g. process priority, maximum pool size and queue priority, see the associated instance methods.



"
Class {
	#name : #BlTktWorkerProvider,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'name',
		'maxPoolSize',
		'processPriority',
		'workerPoolClass',
		'mutex'
	],
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #factory }
BlTktWorkerProvider class >> highUICPUBoundPool [
	^ self new highUICPUBoundPool; service
]

{ #category : #factory }
BlTktWorkerProvider class >> highUIExternalResourceBoundPool [
	^ self new highUIExternalResourceBoundPool; service
]

{ #category : #factory }
BlTktWorkerProvider class >> lowUIUserExecutionPool [
	^ self new lowUIUserExecutionPool; service
]

{ #category : #factory }
BlTktWorkerProvider class >> nonUIMultiPool [
	^ self new nonUIMultiPool; service
]

{ #category : #factory }
BlTktWorkerProvider class >> nonUISinglePool [
	^ self new nonUISinglePool; service
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> highUICPUBoundPool [
	"High Priority Async UI CPU bound: maxPoolSize: 2, priority: 35"
	self
		name: 'Bloc UI CPU Bound';
		priorityQueue;
		maxPoolSize: 2;
		highUIPriority
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> highUIExternalResourceBoundPool [
	"High Priority Async UI External Resource bound: maxPool: 5 or 8, priority: 35"
	self
		name: 'Bloc UI External Resource Bound';
		priorityQueue;
		maxPoolSize: 8;
		highUIPriority
]

{ #category : #'accessing - named priorities' }
BlTktWorkerProvider >> highUIPriority [
	self processPriority: Processor userSchedulingPriority - 5
]

{ #category : #initialization }
BlTktWorkerProvider >> initialize [
	super initialize.
	mutex := Mutex new.
	name := 'User'.
	maxPoolSize := 4.
	processPriority := Processor userSchedulingPriority - 5.
	workerPoolClass := BlTktCommonQueueWorkerPool.
]

{ #category : #'accessing - named priorities' }
BlTktWorkerProvider >> lowUIPriority [
	self processPriority: Processor userSchedulingPriority - 7
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> lowUIUserExecutionPool [
	"Low Priority Async UI (Playground execution): maxPoolSize: 2, , priority: 33"
	self
		name: 'Bloc UI Code Snippets';
		priorityQueue;
		maxPoolSize: 2;
		lowUIPriority
]

{ #category : #accessing }
BlTktWorkerProvider >> maxPoolSize [
	<return: #Integer>
	^ maxPoolSize
]

{ #category : #accessing }
BlTktWorkerProvider >> maxPoolSize: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker max. pool size must be a positive integer' ].
	maxPoolSize := anInteger
]

{ #category : #accessing }
BlTktWorkerProvider >> name [
	<return: #String>
	^ name
]

{ #category : #accessing }
BlTktWorkerProvider >> name: aString [
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty ] ] 
		description: [ 'Worker name must be a non-empty string' ].
	name := aString
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> nonUIMultiPool [
	"Non-UI background processing (multiple): maxPoolSize: 2, priority: 30"
	self
		name: 'Non-UI Single Processing';
		maxPoolSize: 2;
		nonUIPriority
]

{ #category : #'accessing - named priorities' }
BlTktWorkerProvider >> nonUIPriority [
	self processPriority: Processor userBackgroundPriority
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> nonUISinglePool [
	"Non-UI background processing (single) : maxPoolSize: 1, priority: 30"
	self
		name: 'Non-UI Single Processing';
		maxPoolSize: 1;
		nonUIPriority
]

{ #category : #builder }
BlTktWorkerProvider >> pool [
	<return: #TKTCommonQueueWorkerPool>
	| aPool |
	aPool := self workerPoolClass new.
	aPool
		name: self name;
		processPriority: self processPriority;
		poolMaxSize: self maxPoolSize.
	^ aPool
]

{ #category : #accessing }
BlTktWorkerProvider >> priorityQueue [
	self workerPoolClass: BlTktCommonPriorityQueueWorkerPool
]

{ #category : #accessing }
BlTktWorkerProvider >> processPriority [
	<return: #Integer>
	^ processPriority
]

{ #category : #accessing }
BlTktWorkerProvider >> processPriority: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker process priority must be a positive integer' ].
	processPriority := anInteger
]

{ #category : #builder }
BlTktWorkerProvider >> service [
	<return: #TKTCommonQueueWorkerPool>
	^ mutex critical: [
		| aPoolOrNil |
		aPoolOrNil := self serviceManager poolWorkerNamed: self name.
		aPoolOrNil ifNil: [ self pool start ] ]
]

{ #category : #accessing }
BlTktWorkerProvider >> serviceManager [
	<return: #TKTServiceManager>
	^ TKTConfiguration serviceManager
]

{ #category : #accessing }
BlTktWorkerProvider >> workerPoolClass [
	<return: #BlTktCommonQueueWorkerPool>
	^ workerPoolClass
]

{ #category : #accessing }
BlTktWorkerProvider >> workerPoolClass: aClass [
	self 
		assert: [ aClass isNotNil ] 
		description: [ 'Worker pool class must be non-nil' ].
	workerPoolClass := aClass
]
