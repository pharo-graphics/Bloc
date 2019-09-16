"
${class:BlTktWorkerProvider}$ provides a number of convenience methods for submitting tasks at different priorities.  The intention is that the supplied set of queues will be sufficient when submitting tasks in all cases but a few exceptions.

The main UI processing process runs at priority 40 (${method:name=ProcessorScheduler>>#userSchedulingPriority}$ (39 during development).  The design goal is to be keep the UI responsive by reducing the work done by the UI process to responding to user input and any other processing that is restricted to the UI process for thread safety reasons.

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
		'workerPoolClass'
	],
	#classVars : [
		'ServiceMutex'
	],
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #factory }
BlTktWorkerProvider class >> highUICPUBoundPool [
	^ self 
		serviceNamed: self highUICPUBoundPoolName 
		ifMissing: [ self new highUICPUBoundPool; service ]
]

{ #category : #defaults }
BlTktWorkerProvider class >> highUICPUBoundPoolName [
	^ 'Bloc UI CPU Bound'
]

{ #category : #factory }
BlTktWorkerProvider class >> highUIExternalResourceBoundPool [
	^ self 
		serviceNamed: self highUIExternalResourceBoundPoolName 
		ifMissing: [ self new highUIExternalResourceBoundPool; service ]
]

{ #category : #defaults }
BlTktWorkerProvider class >> highUIExternalResourceBoundPoolName [
	^ 'Bloc UI External Resource Bound'
]

{ #category : #'class initialization' }
BlTktWorkerProvider class >> initialize [
	<script>
	ServiceMutex := Mutex new.
]

{ #category : #factory }
BlTktWorkerProvider class >> lowUIUserExecutionPool [
	^ self 
		serviceNamed: self lowUIUserExecutionPoolName
		ifMissing: [ self new lowUIUserExecutionPool; service ]
]

{ #category : #defaults }
BlTktWorkerProvider class >> lowUIUserExecutionPoolName [
	^ 'Bloc UI Code Snippets'
]

{ #category : #factory }
BlTktWorkerProvider class >> nonUIMultiPool [
	^ self 
		serviceNamed: self nonUIMultiPoolName
		ifMissing: [ self new nonUIMultiPool; service ]
]

{ #category : #defaults }
BlTktWorkerProvider class >> nonUIMultiPoolName [
	^ 'Non-UI Multi Processing'
]

{ #category : #factory }
BlTktWorkerProvider class >> nonUISinglePool [
	^ self 
		serviceNamed: self nonUISinglePoolName
		ifMissing: [ self new nonUISinglePool; service ]
]

{ #category : #defaults }
BlTktWorkerProvider class >> nonUISinglePoolName [
	^ 'Non-UI Single Processing'
]

{ #category : #defaults }
BlTktWorkerProvider class >> serviceManager [
	<return: #TKTServiceManager>
	^ TKTConfiguration serviceManager
]

{ #category : #factory }
BlTktWorkerProvider class >> serviceNamed: aServiceName ifMissing: aValuable [
	<return: #TKTCommonQueueWorkerPool or: nil>
	^ ServiceMutex critical: [
		| aPoolOrNil |
		aPoolOrNil := self serviceManager poolWorkerNamed: aServiceName.
		aPoolOrNil ifNil: aValuable ]
]

{ #category : #factory }
BlTktWorkerProvider class >> spotterPool [

	^ self 
		serviceNamed: self spotterPoolName 
		ifMissing: [ self new spotterPool; service ]
]

{ #category : #defaults }
BlTktWorkerProvider class >> spotterPoolName [

	^ 'Spotter Search'
]

{ #category : #'configurations - basic' }
BlTktWorkerProvider >> exemplify [
	self exemplifyName.
	self exemplifyPriority.
]

{ #category : #'configurations - basic' }
BlTktWorkerProvider >> exemplifyName [
	self name: 'Example of ', self name asString
]

{ #category : #'configurations - basic' }
BlTktWorkerProvider >> exemplifyPriority [
	self processPriority: Processor userBackgroundPriority + 1
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> highUICPUBoundPool [
	"High Priority Async UI CPU bound: maxPoolSize: 2, priority: 35"
	self
		name: self class highUICPUBoundPoolName;
		priorityQueue;
		poolMaxSize: 2;
		highUIPriority
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> highUIExternalResourceBoundPool [
	"High Priority Async UI External Resource bound: maxPool: 5 or 8, priority: 35"

	self
		name: self class highUIExternalResourceBoundPoolName;
		priorityQueue;
		poolMaxSize: 8;
		highUIPriority
]

{ #category : #'configurations - priorities' }
BlTktWorkerProvider >> highUIPriority [
	self processPriority: Processor userSchedulingPriority - 5
]

{ #category : #initialization }
BlTktWorkerProvider >> initialize [
	super initialize.
	name := 'User'.
	maxPoolSize := 4.
	processPriority := Processor userSchedulingPriority - 5.
	workerPoolClass := BlTktCommonQueueWorkerPool.
]

{ #category : #'configurations - priorities' }
BlTktWorkerProvider >> lowUIPriority [
	self processPriority: Processor userSchedulingPriority - 7
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> lowUIUserExecutionPool [
	"Low Priority Async UI (Playground execution): maxPoolSize: 2, , priority: 33"

	self
		name: self class lowUIUserExecutionPoolName;
		priorityQueue;
		poolMaxSize: 2;
		lowUIPriority
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
		name: self class nonUIMultiPoolName;
		poolMaxSize: 2;
		nonUIPriority
]

{ #category : #'configurations - priorities' }
BlTktWorkerProvider >> nonUIPriority [
	self processPriority: Processor userBackgroundPriority
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> nonUISinglePool [
	"Non-UI background processing (single) : maxPoolSize: 1, priority: 30"

	self
		name: self class nonUISinglePoolName;
		poolMaxSize: 1;
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
		poolMaxSize: self poolMaxSize.
	^ aPool
]

{ #category : #accessing }
BlTktWorkerProvider >> poolMaxSize [
	<return: #Integer>
	^ maxPoolSize
]

{ #category : #accessing }
BlTktWorkerProvider >> poolMaxSize: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker pool max. size must be a positive integer' ].
	maxPoolSize := anInteger
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
	^ self class 
			serviceNamed: self name 
			ifMissing: [ self pool start ]
]

{ #category : #accessing }
BlTktWorkerProvider >> serviceManager [
	<return: #TKTServiceManager>
	^ self class serviceManager
]

{ #category : #'configurations - pools' }
BlTktWorkerProvider >> spotterPool [
	"Spotter search processing: maxPoolSize: 1, priority: 37"
	self
		name: self class spotterPoolName;
		priorityQueue;
		poolMaxSize: 1;
		spotterPriority
]

{ #category : #'configurations - priorities' }
BlTktWorkerProvider >> spotterPriority [
	"Process priority for spotter search calculation.  Higher than UI background processing."

	self processPriority: Processor userSchedulingPriority - 4
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
