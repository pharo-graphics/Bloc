Class {
	#name : #BlSpaceFrameTaskPhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Bloc-Space - Frame'
}

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
	"process animations and other runnable tasks"
	aSpace
		dispatchTimeEvent: BlSpaceTasksEndEvent
		during: [ :theSpace | theSpace runTasks ]
]
