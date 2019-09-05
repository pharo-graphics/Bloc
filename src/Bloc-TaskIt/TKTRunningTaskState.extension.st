Extension { #name : #TKTRunningTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	| cancelState taskProcess activeContext timeoutContext |

	cancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.

	taskProcess := aTaskExecution executionProcess.
	taskProcess == Processor activeProcess ifTrue: [ 
		aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
		BlTaskItSignal emitValuable: aTaskExecution task message: #selfTerminated.
		^cancelState signalExplicitlyTerminatedException. ].

	taskProcess suspend.	
	activeContext := taskProcess suspendedContext.
	timeoutContext := [ cancelState signalExplicitlyTerminatedException ] asContext.
	timeoutContext privSender: activeContext.
	taskProcess suspendedContext: timeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
	taskProcess resume.
	BlTaskItSignal emitValuable: aTaskExecution task message: #terminationInjected.
]
