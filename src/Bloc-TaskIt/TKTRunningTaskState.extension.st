Extension { #name : #TKTRunningTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	| cancelState activeContext timeoutContext |

	cancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.
	
	activeContext := aTaskExecution executionProcess suspendedContext.
	timeoutContext := [ cancelState signalExplicitlyTerminatedException ] asContext.
	timeoutContext privSender: activeContext.
	aTaskExecution executionProcess suspendedContext: timeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
	BlTaskItSignal emitValuable: aTaskExecution task message: #terminationInjected.
]
