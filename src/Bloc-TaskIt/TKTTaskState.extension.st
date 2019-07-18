Extension { #name : #TKTTaskState }

{ #category : #'*Bloc-TaskIt' }
TKTTaskState >> suspendTaskExecution: aTaskExecution reason: aReason [

	self subclassResponsibility
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	self subclassResponsibility
]
