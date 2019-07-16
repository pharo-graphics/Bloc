Class {
	#name : #BlTktNotifyingTaskExecution,
	#superclass : #TKTTaskExecution,
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #evaluating }
BlTktNotifyingTaskExecution >> doExecuteTask [
	TKTConfiguration runner scheduleNotifycationEvery: self timeout on: self.
	^ super doExecuteTask
]

{ #category : #testing }
BlTktNotifyingTaskExecution >> isCancelRequested [
	<return: #Boolean>
	^ task isCancelRequested
]

{ #category : #accessing }
BlTktNotifyingTaskExecution >> timeout [
	^ 200 milliSeconds
]
