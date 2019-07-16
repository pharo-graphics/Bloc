Extension { #name : #TKTReadyTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTReadyTaskState >> userCancelTaskExecution: aTaskExecution reason: aReason [

	aTaskExecution setUserCancelStateWithReason: aReason
]
