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
	BlAsyncUIWorkerPool
	BlHousekeepingWorkerPool) do: [ :class |
		aStream
			print: class;
			<< ': ';
			print: class asClass instanceCount;
			cr ]
]

{ #category : #printing }
BlTaskItStatus >> statusOn: aStream [
	"Print a summary of the system status on aStream"

	self variableSizedPool: BlAsyncUIWorkerPool on: aStream.
	aStream cr; cr.
	self variableSizedPool: BlHousekeepingWorkerPool on: aStream.
	aStream cr; cr.
	self workerPool: TKTConfiguration runner on: aStream.
	aStream cr; cr.
	self instanceCountsOn: aStream
]

{ #category : #accessing }
BlTaskItStatus >> statusString [

	^String streamContents: [ :stream | self statusOn: stream ]
]

{ #category : #printing }
BlTaskItStatus >> variableSizedPool: aPoolClass on: aStream [

	| poolSizes workerPools |

	workerPools := aPoolClass workerPools.
	poolSizes := workerPools keys sorted.
	aStream
		print: aPoolClass;
		cr; cr.

	aStream << 'Active Pool Sizes: '.
	poolSizes ifEmpty: 
		[ aStream << '(none)' ]
	ifNotEmpty: [ 
		poolSizes 
			do: [ :key | aStream print: key ]
			separatedBy: [ aStream << ', ' ] ].
	aStream cr; cr.

	poolSizes do: [ :size |
		self workerPool: (workerPools at: size) on: aStream.
		aStream cr. ]
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
