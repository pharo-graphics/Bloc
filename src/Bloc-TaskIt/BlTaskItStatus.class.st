"
BlTaskItStatus provides a very low level overview of TaskIt pools used by Bloc.

Since this is typically required when the UI is failing to update the output is a simple string that can easily be printed or written to file.

To view the current status:

[[[
BlTaskItStatus new
]]]

"
Class {
	#name : #BlTaskItStatus,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Status'
}

{ #category : #printing }
BlTaskItStatus >> commonPoolsOn: aStream [
	"Print any common pools that exist.
	Since there isn't a common root for the instances, search allInstances"

	(TKTCommonQueueWorkerPool allInstances select: [ :each |
		each name beginsWith: 'CommonPool-' ]) do: [ :pool |
			self workerPool: pool on: aStream.
			aStream cr; cr ]
]

{ #category : #printing }
BlTaskItStatus >> gtStatusFor: aView [
	<gtView>

	^aView textEditor 
		title: 'Status' translated;
		priority: 1;
		look: BrGlamorousCodeEditorLook new;
		text: [ self statusString asRopedText ]
]

{ #category : #printing }
BlTaskItStatus >> instanceCountsOn: aStream [

	aStream
		<< 'Instance Counts:';
		cr; cr.

	#(TKTNewProcessTaskRunner 
	TKTLocalProcessTaskRunner
	TKTWorkerPool
	TKTCommonQueueWorkerPool
	BlTktCommonQueueWorkerPool
	BlTktCommonPriorityQueueWorkerPool) do: [ :class |
		aStream
			print: class;
			<< ': ';
			print: class asClass instanceCount;
			cr ]
]

{ #category : #printing }
BlTaskItStatus >> statusOn: aStream [
	"Print a summary of the system status on aStream"

	TKTConfiguration serviceManager services do: [ :eachService | 
		eachService class = TKTWatchDog ifTrue: [ 
			eachService pool ifNotNil: [ :aPool |
				self workerPool: eachService pool on: aStream ] ] ].
	aStream cr; cr.
	aStream cr; cr.
	self commonPoolsOn: aStream.
	self instanceCountsOn: aStream
]

{ #category : #accessing }
BlTaskItStatus >> statusString [

	^String streamContents: [ :stream | self statusOn: stream ]
]

{ #category : #printing }
BlTaskItStatus >> workerPool: pool on: aStream [

	| freeWorkers |
	
	freeWorkers := pool workers select: #isFree.
	aStream 
		<< 'Name: '
		<< pool name; cr;
		<< 'Queue Size: ';
		print: pool taskQueue size; cr;
		<< 'Busy Workers: ';
		print: pool workers size - freeWorkers size; cr;
		<< 'Free Workers: ';
		print: freeWorkers size; cr;
		<< 'Failed Tasks: ';
		print: pool failedTasks size; cr;
		<< 'Pool Max Size: ';
		<< pool poolMaxSize; cr.

]
