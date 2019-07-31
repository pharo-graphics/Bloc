Extension { #name : #TKTTaskExecution }

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> name [ 
	<return: #String>
	^ task name
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> setExplicitlyTerminatedStateWithReason: aReason [
	state := BlTktExplicitlyTerminatedTaskState new reason: aReason
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> task [ 
	<return: #TKTTask>
	^ task
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^ task taskPriority
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> terminateWithReason: aReason [
	state terminateTaskExecution: self reason: aReason
]
