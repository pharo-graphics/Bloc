"
BlVariableSizeWorkerPool is an abstract superclass that provides a framework for specifying the maximum number of concurrent tasks that may be executed on a task-by-task basis.

As an example, the original driver for this was sizing and retrieving files from the image cache.   The file system responds quickly, primtive file access blocks the VM and potentially places heavy load on the memory management, so only 1 file at a time is loaded.  By contrast retrieving images over the internet is much slower so we want to be able to retrieve multiple images simultaneously.

!!Public API and Key Messages

Subclasses are responsible for implementing the main public method:

- schedul:maxPoolSize:	schedule the supplied valuable for execution, allowing up to maxPoolSize conccurent instances.


!!Internal Representation and Key Implementation Points.

Each different maxPoolSize is implemented as a separate pool, so if there are pools for 1, 3 and 5 concurrent operations a total of 9 (5+3+1) processes can be forked at once.
"
Class {
	#name : #BlVariableSizeWorkerPool,
	#superclass : #TKTCommonQueueWorkerPool,
	#classInstVars : [
		'workerPools'
	],
	#category : #'Bloc-TaskIt-Worker'
}

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

{ #category : #scheduling }
BlVariableSizeWorkerPool class >> schedule: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^self subclassResponsibility 

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
			start;
			yourself ]
]

{ #category : #accessing }
BlVariableSizeWorkerPool class >> workerPools [

	^workerPools
]
