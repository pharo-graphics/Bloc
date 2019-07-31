Extension { #name : #TKTReadyTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTReadyTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason
]
