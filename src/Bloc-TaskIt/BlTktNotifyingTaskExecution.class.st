Class {
	#name : #BlTktNotifyingTaskExecution,
	#superclass : #TKTTaskExecution,
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #testing }
BlTktNotifyingTaskExecution >> isSuspendRequested [
	<return: #Boolean>
	^ task isSuspendRequested
]

{ #category : #accessing }
BlTktNotifyingTaskExecution >> name [
	<return: #String>
	^ task name
]

{ #category : #accessing }
BlTktNotifyingTaskExecution >> timeout [
	^ 200 milliSeconds
]
