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
		critical: [ (workers reject: #isRunning)
				do: [ :worker | 
					BlTaskItSignal
						emitValuable: worker currentTaskExecution
						message: 'Moved not running task to failed queue'.
					failedTasks add: worker currentTaskExecution.
					workers remove: worker ].
			(workers select: #isSuspended)
				do: [ :worker | 
					BlTaskItSignal
						emitValuable: worker currentTaskExecution
						message: 'Moved suspended task to failed queue'.
					failedTasks add: worker currentTaskExecution.
					worker stopAfterTaskCompleted.
					workers remove: worker ].
			failedTasks
				ifNotEmpty: [ self
						traceCr: failedTasks size asString , ' Failed tasks encountered' ].
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

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> scheduleTaskExecution: aTaskExecution [

	| add |
	mutex critical: [ 
		self ensureIsBeingWatched.
		self privateManageWorkersBefore.
		"Don't schedule the task if it is already being executed"
		add := true.
		aTaskExecution entryIdentifier ifNotNil: [ :identifier |
			workers
				detect: [ :each | each entryIdentifier = identifier ] 
				ifFound: [ :entry |
					self flag: #remove.
					StringSignal emit: 'worker duplicate found'.
					add := false ] ].
		add ifTrue: [ taskQueue nextPut: aTaskExecution ].
		self privateManageWorkersAfter ]
]

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> start [ 
	"Bloc uses a pool of existing runners, rather than creating a new one on demand.
	Only start if not already started."

	^dog ifNil: [ super start ]
]
