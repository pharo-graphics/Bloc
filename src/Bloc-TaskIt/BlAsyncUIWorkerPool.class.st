"
BlAsyncUIWorkerPool is a TKTCommonQueueWorkerPool that:

- uses a WaitfreePriorityQueue so that tasks are executed by task priority (rather than FIFO).
- runs the workers at low priority so that the UI thread is still responsive (see BlTKTBackgroundProcessProvider>>createProcessDoing:named:)

Public API and Key Messages

The public API and key messages are the same as for TKTCommonWorkerPool.

"
Class {
	#name : #BlAsyncUIWorkerPool,
	#superclass : #BlVariableSizeWorkerPool,
	#classVars : [
		'UseDefaultRunner'
	],
	#category : #'Bloc-TaskIt-Worker'
}

{ #category : #scheduling }
BlAsyncUIWorkerPool class >> future: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^self useDefaultRunner ifTrue: 
		[ aValuable asLoggingTask future ]
	ifFalse: [ 
		TKTConfiguration processProvider: BlTKTBackgroundProcessProvider new during: [ 
			(self withPoolSize: maxPoolSize) future: aValuable asLoggingTask ] ].

]

{ #category : #'class initialization' }
BlAsyncUIWorkerPool class >> initialize [ 
	<script>

	self stopAll.
	workerPools := Dictionary new.

]

{ #category : #scheduling }
BlAsyncUIWorkerPool class >> schedule: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^self useDefaultRunner ifTrue: 
		[ aValuable asLoggingTask schedule ]
	ifFalse: [ 
		TKTConfiguration processProvider: BlTKTBackgroundProcessProvider new during: [ 
		(self withPoolSize: maxPoolSize) schedule: aValuable asLoggingTask ] ].

]

{ #category : #debugging }
BlAsyncUIWorkerPool class >> useDefaultRunner [
	"Answer a boolean indicating whether the default (calling priority) runner should be used"

	^UseDefaultRunner ifNil: [ false ]
]

{ #category : #debugging }
BlAsyncUIWorkerPool class >> useDefaultRunner: aBoolean [
	"Set the flag indicating whether to use the default (calling priority) runner"

	UseDefaultRunner := aBoolean 
]

{ #category : #initialization }
BlAsyncUIWorkerPool >> initialize [ 

	super initialize.
	taskQueue := AtomicSharedPriorityQueue new.
	self name: 'AsyncElementWorker-', self identityHash asString.
]

{ #category : #printing }
BlAsyncUIWorkerPool >> printOn: aStream [
	| freeWorkers | 
	freeWorkers := workers select: #isFree.
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: 'name: ';
		nextPutAll: name;
		nextPutAll: ', queueSize: ';
		print: taskQueue size;
		nextPutAll: ', busyWorkers: ';
		print: workers size - freeWorkers size;
		nextPutAll: ', freeWorkers: ';
		print: freeWorkers size;
		nextPutAll: ', poolMaxSize: ';
		print: poolMaxSize;
		nextPutAll: ')'
]
