"
${class:BlVariableSizeWorkerPool}$ is an abstract class that provides a framework for specifying the maximum number of concurrent tasks that may be executed on a task-by-task basis.

As an example, the original driver for this was sizing and retrieving files from the image cache.   The file system responds quickly, primtive file access blocks the VM and potentially places heavy load on the memory management, so only 1 file at a time is loaded.  By contrast retrieving images over the internet is much slower so we want to be able to retrieve multiple images simultaneously.

!!Public API and Key Messages

Subclasses are responsible for implementing the main public method:

- ${method:BlVariableSizeWorkerPool class>>#schedule:maxPoolSize:}$	schedule the supplied valuable for execution, allowing up to maxPoolSize conccurent instances.

!!Internal Representation and Key Implementation Points.

Each different maxPoolSize is implemented as a separate pool, so if there are pools for 1, 3 and 5 concurrent operations a total of 9 (5+3+1) processes can be forked at once.

!!Subclasses 

${class:BlVariableSizeWorkerPool|show=gtSubclassesFor:|expanded=true|height=111}$  
"
Class {
	#name : #BlVariableSizeWorkerPool,
	#superclass : #TKTCommonQueueWorkerPool,
	#classInstVars : [
		'workerPools'
	],
	#category : #'Bloc-TaskIt-Worker'
}

{ #category : #accessing }
BlVariableSizeWorkerPool class >> defaultName [
	"Return a default worker pool name"
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlVariableSizeWorkerPool class >> defaultPoolSize [
	"Return a default worker pool size"
	<return: #Integer>
	^ self subclassResponsibility
]

{ #category : #scheduling }
BlVariableSizeWorkerPool class >> future: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^self subclassResponsibility 

]

{ #category : #'class initialization' }
BlVariableSizeWorkerPool class >> initialize [ 
	<script>

	self stopAll.
	workerPools := Dictionary new.

]

{ #category : #testing }
BlVariableSizeWorkerPool class >> isFree [
	"Answer a boolean indicating whether all of the receiver's worker pools are free (not busy)"

	^workerPools allSatisfy: [ :each | each isFree ]
]

{ #category : #scheduling }
BlVariableSizeWorkerPool class >> schedule: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^ (self withPoolSize: maxPoolSize) schedule: aValuable.

]

{ #category : #scheduling }
BlVariableSizeWorkerPool class >> schedule: aValuable named: aString maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable named aValuableName with maxPoolSize worker pools"

	^ (self withPoolSize: maxPoolSize) schedule: aValuable named: aString.

]

{ #category : #managing }
BlVariableSizeWorkerPool class >> stopAll [
	<script>
	"Stop the all worker pools and remove the reference to it"

	| keys |

	workerPools ifNil: [ ^self ].
	keys := workerPools keys.
	keys do: [ :key |
		(workerPools at: key) stop.
		workerPools removeKey: key ].

]

{ #category : #accessing }
BlVariableSizeWorkerPool class >> withPoolSize: maxPoolSize [
	"Answer an instance of the receiver with the supplied maximum pool size"

	^workerPools at: maxPoolSize ifAbsentPut: [ 
		self new
			poolMaxSize: maxPoolSize;
			name: self defaultName;
			start;
			yourself ]
]

{ #category : #accessing }
BlVariableSizeWorkerPool class >> workerPools [

	^workerPools
]

{ #category : #initialization }
BlVariableSizeWorkerPool >> initialize [
	super initialize.
	self poolMaxSize: self class defaultPoolSize.
	self name: self class defaultName, '-', self identityHash asString.
]

{ #category : #testing }
BlVariableSizeWorkerPool >> isFree [

	^ taskQueue isEmpty and: [ workers allSatisfy: [ :each | each isFree ] ]
]

{ #category : #printing }
BlVariableSizeWorkerPool >> printOn: aStream [
	| freeWorkers | 
	freeWorkers := self privateFreeWorkers.
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: 'name:';
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

{ #category : #accessing }
BlVariableSizeWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ self subclassResponsibility
]

{ #category : #schedulling }
BlVariableSizeWorkerPool >> schedule: aValuable [
	<return: #BlTaskItNamedTask>
	| aTask |
	aTask := aValuable asLoggingTask asNamedTask.
	TKTConfiguration 
		processProvider: self processProvider 
		during: [ super schedule: aTask ].
	^ aTask
]

{ #category : #schedulling }
BlVariableSizeWorkerPool >> schedule: aValuable named: aTaskName [
	<return: #BlTaskItNamedTask>
	| aTask |
	aTask := aValuable asLoggingTask asNamedTask.
	aTask name: aTaskName.
	self schedule: aTask.
	^ aTask
]
