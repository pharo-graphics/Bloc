Class {
	#name : #BlSpaceFrameTaskPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #testing }
BlSpaceFrameTaskPhase >> isSettledIn: aSpace [
	"Return true if aSpace task queue has reached equilibrium"

	^ aSpace taskQueue isSettled
]

{ #category : #testing }
BlSpaceFrameTaskPhase >> isTaskPhase [
	^ true
]

{ #category : #accessing }
BlSpaceFrameTaskPhase >> name [
	^ 'Tasks processing'
]

{ #category : #actions }
BlSpaceFrameTaskPhase >> runOn: aSpace [
	"Process animations and other runnable tasks"

	aSpace
		dispatchTimeEvent: BlSpaceTasksEndEvent
		during: [ aSpace runTasks ]
]
