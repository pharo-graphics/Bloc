Extension { #name : #TKTTaskExecution }

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> setSuspendedTaskStateWithReason: aReason [

	state := BlTktSuspendedTaskState new
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^ task taskPriority
]
