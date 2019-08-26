Class {
	#name : #BlTktCommonQueueWorkerPool,
	#superclass : #TKTCommonQueueWorkerPool,
	#traits : '(TBlDebug + TBlTktCommandTaskScheduler) - {#processProvider}',
	#classTraits : 'TBlDebug classTrait + TBlTktCommandTaskScheduler classTrait',
	#instVars : [
		'processPriority'
	],
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> ensureIsWorking [
	"Over-write to not terminate worker processes.
	Trying to terminate idle workers produces more delays than resource saving."

	mutex
		critical: [ failedTasks
				addAll: (self workers reject: #isRunning thenCollect: #currentTaskExecution).
			failedTasks
				ifNotEmpty:
					[ self logCr: failedTasks size asString , ' Failed tasks encountered' ].
			(workers reject: #isRunning)
				do: [ :w | 
					workers remove: w ].
			self privateManageWorkersBefore.
			self privateManageWorkersAfter ]
]

{ #category : #initialization }
BlTktCommonQueueWorkerPool >> initialize [
	super initialize.
	processPriority := Processor userSchedulingPriority.
]

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> printOn: aStream [
	name ifNil: [ aStream nextPutAll: 'a '; nextPutAll: self className. ^ self ].
	aStream nextPutAll: name
]

{ #category : #private }
BlTktCommonQueueWorkerPool >> privateManageWorkersAfter [
	"Trying to terminate idle workers produces more delays than resource saving.
	Only create a worker if required (workers are light-weight anyway)"
	| free |

	free := self privateFreeWorkers.
	taskQueue size > free size
		ifTrue: [ self privateSpawnWorkerIfNeeded ]
]

{ #category : #private }
BlTktCommonQueueWorkerPool >> privateRemoveIdleWorkerIfNeeded [
	"Trying to terminate idle workers produces more delays than resource saving.
	Leave workers waiting on the queue (they're light-weight anyway)"
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processPriority [
	<return: #Integer>
	^ processPriority
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processPriority: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker process priority must be a positive integer' ].
	processPriority := anInteger
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTktProcessProvider new processPriority: self processPriority
]
