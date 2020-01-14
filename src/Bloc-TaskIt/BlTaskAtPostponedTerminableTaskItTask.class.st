Class {
	#name : #BlTaskAtPostponedTerminableTaskItTask,
	#superclass : #BlTaskAtTask,
	#instVars : [
		'pool',
		'shouldTerminate',
		'wasExecuted',
		'mutex'
	],
	#category : #'Bloc-TaskIt-Support'
}

{ #category : #accessing }
BlTaskAtPostponedTerminableTaskItTask >> command [
	<return: #BlTktTerminableCommand>
	^ valuable
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTaskItTask >> command: aCommand [
	self 
		assert: [ aCommand isNotNil ] 
		description: [ 'Command must be non-nil' ].
	valuable := aCommand asBlTktTerminableCommand.
]

{ #category : #initialization }
BlTaskAtPostponedTerminableTaskItTask >> initialize [
	super initialize.
	shouldTerminate := false.
	wasExecuted := false.
	mutex := Mutex new.
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTaskItTask >> pool [
	<return: #TKTCommonQueueWorkerPool>
	^ pool
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTaskItTask >> pool: aTKTCommonQueueWorkerPool [
	self 
		assert: [ aTKTCommonQueueWorkerPool isNotNil ] 
		description: [ 'TaskIt worker pool must be non-nil' ].
	pool := aTKTCommonQueueWorkerPool
]

{ #category : #accessing }
BlTaskAtPostponedTerminableTaskItTask >> scheduledTime: aTime [
	scheduledTime := aTime
]

{ #category : #actions }
BlTaskAtPostponedTerminableTaskItTask >> terminate [
	mutex critical: [ 
		wasExecuted ifFalse: [ 
			shouldTerminate := true.
			^ self ] ].
	self command terminate.
]

{ #category : #evaluating }
BlTaskAtPostponedTerminableTaskItTask >> value [
	mutex critical: [ 
		shouldTerminate ifTrue: [ ^ nil ].
		wasExecuted := true.
		self pool schedule: self command ]
]
