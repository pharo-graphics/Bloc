"
${class:BlHousekeepingWorkerPool}$ is a ${class:TKTCommonQueueWorkerPool}$ that runs the workers at ${method:ProcessorScheduler>>#userBackgroundPriority}$ and limits the number of concurrent tasks so that the UI thread is still responsive.

Public API and Key Messages

The public API and key messages are the same as for ${class:TKTCommonQueueWorkerPool}$.

"
Class {
	#name : #BlHousekeepingWorkerPool,
	#superclass : #BlVariableSizeWorkerPool,
	#classVars : [
		'Current'
	],
	#category : #'Bloc-TaskIt-Worker'
}

{ #category : #scheduling }
BlHousekeepingWorkerPool class >> future: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	TKTConfiguration processProvider: BlTKTHousekeepingProcessProvider new during: [ 
		(self withPoolSize: maxPoolSize) future: aValuable asLoggingTask ].

]

{ #category : #'class initialization' }
BlHousekeepingWorkerPool class >> initialize [ 
	<script>

	self stopAll.
	workerPools := Dictionary new.

]

{ #category : #scheduling }
BlHousekeepingWorkerPool class >> schedule: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	TKTConfiguration processProvider: BlTKTHousekeepingProcessProvider new during: [ 
		(self withPoolSize: maxPoolSize) schedule: aValuable asLoggingTask ].

]

{ #category : #initialization }
BlHousekeepingWorkerPool >> initialize [ 

	super initialize.
	self name: 'BlHousekeepingWorker-', self identityHash asString.
]

{ #category : #printing }
BlHousekeepingWorkerPool >> printOn: aStream [
	| freeWorkers | 
	freeWorkers := workers select: #isFree.
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: 'name:';
		nextPutAll: name;
		nextPutAll: 'poolMaxSize: ';
		print: poolMaxSize;
		nextPutAll: '; busyWorkers: ';
		print: workers size - freeWorkers size;
		nextPutAll: '; freeWorkers: ';
		print: freeWorkers size;
		nextPutAll: ')'
]
