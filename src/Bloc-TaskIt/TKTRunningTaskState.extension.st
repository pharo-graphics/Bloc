Extension { #name : #TKTRunningTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> primitiveTerminateTaskExecution: aTaskExecution reason: aReason [

	| aCancelState anActiveContext aTimeoutContext |
	self 
		assert: [ Processor activePriority > aTaskExecution executionProcess priority ]
		description: [ 'TaskIt task execution must be terminated from a process with higher priority' ].

	aCancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.	
	anActiveContext := aTaskExecution executionProcess suspendedContext.
	aTimeoutContext := [ aCancelState signalExplicitlyTerminatedException ] asContext.
	aTimeoutContext privSender: anActiveContext.
	aTaskExecution executionProcess suspendedContext: aTimeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
	BlTaskItSignal emitValuable: aTaskExecution task message: #terminationInjected.
]

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> terminateTaskExecution: aTaskExecution atHigherPriorityWithReason: aReason [
	| anActiveProcess anOldPriority |
	anActiveProcess := Processor activeProcess.
	anOldPriority := anActiveProcess priority.
	anActiveProcess priority: aTaskExecution executionProcess priority + 1.
	[ self primitiveTerminateTaskExecution: aTaskExecution reason: aReason ] 
		ensure: [ anActiveProcess priority: anOldPriority ].
	"[ self primitiveTerminateTaskExecution: aTaskExecution reason: aReason ] valueWithoutUserInterruption"
]

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	Processor activePriority > aTaskExecution executionProcess priority
		ifFalse: [ self terminateTaskExecution: aTaskExecution atHigherPriorityWithReason: aReason ]
		ifTrue: [ self primitiveTerminateTaskExecution: aTaskExecution reason: aReason ]
]
