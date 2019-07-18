Extension { #name : #BlTktExplicitlyTerminatedTaskState }

{ #category : #'*Bloc-TaskIt' }
BlTktExplicitlyTerminatedTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	| cancelState activeContext timeoutContext |

	cancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.
	
	activeContext := aTaskExecution executionProcess suspendedContext.
	timeoutContext := [ cancelState signalExplicitlyTerminatedException ] asContext.
	timeoutContext privSender: activeContext.
	aTaskExecution executionProcess suspendedContext: timeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason
]
