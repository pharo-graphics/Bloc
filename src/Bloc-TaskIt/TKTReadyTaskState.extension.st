Extension { #name : #TKTReadyTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTReadyTaskState >> suspendTaskExecution: aTaskExecution reason: aReason [

	aTaskExecution setSuspendedTaskStateWithReason: aReason
]
