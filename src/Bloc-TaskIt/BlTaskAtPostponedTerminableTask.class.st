Class {
	#name : #BlTaskAtPostponedTerminableTask,
	#superclass : #BlTaskAtTask,
	#instVars : [
		'pool',
		'shouldTerminate',
		'wasExecuted',
		'notScheduledHandler',
		'executionMutex'
	],
	#category : #'Bloc-TaskIt-Postponed Tasks'
}

{ #category : #initialization }
BlTaskAtPostponedTerminableTask >> beRegularNotScheduledHandler [
	self notScheduledHandler: BlTaskAtNotScheduledHandler default 
]

{ #category : #initialization }
BlTaskAtPostponedTerminableTask >> beShiftingNotScheduledHandler [
	self notScheduledHandler: BlTaskAtNotScheduledHandler shifting 
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> command [
	<return: #BlTktTerminableCommand>
	^ valuable
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> command: aCommand [
	self 
		assert: [ aCommand isNotNil ] 
		description: [ 'Command must be non-nil' ].
	valuable := aCommand asBlTktCommand asBlTktTerminableCommand.
]

{ #category : #defaults }
BlTaskAtPostponedTerminableTask >> defaultNotScheduledHandler [
	^ BlTaskAtNotScheduledHandler default
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> entryIdentifier [
	^ self command entryIdentifier
]

{ #category : #handling }
BlTaskAtPostponedTerminableTask >> handleNotScheduledBecauseOfPreviousTask: aBlTaskAtTask [
	self notScheduledHandler notScheduled: self becauseOf: aBlTaskAtTask
]

{ #category : #initialization }
BlTaskAtPostponedTerminableTask >> initialize [
	super initialize.
	shouldTerminate := false.
	wasExecuted := false.
	executionMutex := Mutex new.
	notScheduledHandler := self defaultNotScheduledHandler.
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> notScheduledHandler [
	^ notScheduledHandler
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> notScheduledHandler: anObject [
	notScheduledHandler := anObject
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> pool [
	<return: #TKTCommonQueueWorkerPool>
	^ pool
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> pool: aTKTCommonQueueWorkerPool [
	self 
		assert: [ aTKTCommonQueueWorkerPool isNotNil ] 
		description: [ 'TaskIt worker pool must be non-nil' ].
	pool := aTKTCommonQueueWorkerPool
]

{ #category : #evaluating }
BlTaskAtPostponedTerminableTask >> privateExecute [
	self pool schedule: self command
]

{ #category : #actions }
BlTaskAtPostponedTerminableTask >> terminate [
	executionMutex critical: [ 
		wasExecuted ifFalse: [ 
			shouldTerminate := true.
			^ self ] ].
	self command terminate.
]

{ #category : #evaluating }
BlTaskAtPostponedTerminableTask >> value [
	executionMutex critical: [ 
		shouldTerminate ifTrue: [ ^ nil ].
		wasExecuted := true.
		self privateExecute ]
]
