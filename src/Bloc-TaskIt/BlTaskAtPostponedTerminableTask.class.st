Class {
	#name : #BlTaskAtPostponedTerminableTask,
	#superclass : #BlTaskAtTask,
	#instVars : [
		'pool',
		'shouldTerminate',
		'wasExecuted',
		'mutex'
	],
	#category : #'Bloc-TaskIt-Postponed Tasks'
}

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
	valuable := aCommand asBlTktTerminableCommand.
]

{ #category : #initialization }
BlTaskAtPostponedTerminableTask >> initialize [
	super initialize.
	shouldTerminate := false.
	wasExecuted := false.
	mutex := Mutex new.
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

{ #category : #accessing }
BlTaskAtPostponedTerminableTask >> scheduledTime: aTime [
	scheduledTime := aTime
]

{ #category : #actions }
BlTaskAtPostponedTerminableTask >> terminate [
	mutex critical: [ 
		wasExecuted ifFalse: [ 
			shouldTerminate := true.
			^ self ] ].
	self command terminate.
]

{ #category : #evaluating }
BlTaskAtPostponedTerminableTask >> value [
	mutex critical: [ 
		shouldTerminate ifTrue: [ ^ nil ].
		wasExecuted := true.
		self privateExecute ]
]
