"
Bloc Main Loop: priority: 39/40
High Priority Async UI CPU bound: maxPoolSize: 2, priority: 35
- e.g. BlFileImageElement
High Priority Async UI External Resource bound: maxPool: 5 or 8, priority: 35
- e.g. BlURLImageElement
Low Priority Async UI (Playground execution): maxPoolSize: 2, , priority: 33
- e.g. Playground expression processing
Non-UI background processing (single) : maxPoolSize: 1, priority: 30
- e.g. BlLocalImageCache housekeeping
Non-UI background processing (multiple): maxPoolSize: 2, priority: 30
- no example yet.

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

{ #category : #'configurations - basic' }
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

{ #category : #'configurations - basic' }
BlTktWorkerProvider >> lowUIPriority [
	self processPriority: Processor userSchedulingPriority - 3
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

{ #category : #'configurations - basic' }
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

{ #category : #'configurations - basic' }
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
