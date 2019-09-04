Extension { #name : #TKTRunningTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> primitiveTerminateTaskExecution: aTaskExecution reason: aReason [

	| cancelState taskProcess activeContext timeoutContext |

	cancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.

	taskProcess := aTaskExecution executionProcess.
	taskProcess suspend.	
	activeContext := taskProcess suspendedContext.
	timeoutContext := [ cancelState signalExplicitlyTerminatedException ] asContext.
	timeoutContext privSender: activeContext.
	taskProcess suspendedContext: timeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
	taskProcess resume.
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
