Extension { #name : #TKTRunningTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTRunningTaskState >> userCancelTaskExecution: aTaskExecution reason: aReason [
	"We likely want to resume the process from the user interface"
	| cancelState activeContext timeoutContext |

	cancelState := BlTktUserCancelledTaskState reason: aReason.
	
	activeContext := aTaskExecution executionProcess suspendedContext.
	timeoutContext := [ cancelState signalCancelledException ] asContext.
	timeoutContext privSender: activeContext.
	aTaskExecution executionProcess suspendedContext: timeoutContext.
	aTaskExecution setUserCancelStateWithReason: aReason.
	aTaskExecution executionProcess suspend.
]
