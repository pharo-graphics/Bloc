Extension { #name : #TKTRunningTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> suspendTaskExecution: aTaskExecution reason: aReason [
	"We likely want to resume the process from the user interface"
	| suspendedState activeContext timeoutContext |

	suspendedState := BlTktSuspendedTaskState reason: aReason.
	
	activeContext := aTaskExecution executionProcess suspendedContext.
	timeoutContext := [ suspendedState signalSuspendedException ] asContext.
	timeoutContext privSender: activeContext.
	aTaskExecution executionProcess suspendedContext: timeoutContext.
	aTaskExecution setSuspendedTaskStateWithReason: aReason.
	aTaskExecution executionProcess suspend.
]
