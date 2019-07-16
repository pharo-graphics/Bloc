Extension { #name : #TKTTaskExecution }

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> setUserCancelStateWithReason: aReason [

	state := BlTktUserCancelledTaskState new
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^ task taskPriority
]

{ #category : #'*Bloc-TaskIt' }
TKTTaskExecution >> userCancelWithReason: reason [

	state userCancelTaskExecution: self reason: reason
]
