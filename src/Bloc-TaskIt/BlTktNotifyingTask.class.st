Class {
	#name : #BlTktNotifyingTask,
	#superclass : #BlTktDecoratedTask,
	#instVars : [
		'notifications',
		'isSuspendRequested'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #converting }
BlTktNotifyingTask >> asNotifyingTask [
	^ self
]

{ #category : #actions }
BlTktNotifyingTask >> cancelRequest [
	self suspendRequest
]

{ #category : #initialization }
BlTktNotifyingTask >> initialize [
	super initialize.
	notifications := BlTaskNotifications new.
	isSuspendRequested := false.
]

{ #category : #testing }
BlTktNotifyingTask >> isSuspendRequested [
	^ isSuspendRequested
]

{ #category : #registration }
BlTktNotifyingTask >> onNotification: aNotificationClass enqueue: aCallback in: anElement [
	notifications 
		addNotification: aNotificationClass 
		handler: [ :aNotification | 
			anElement enqueueTask: (BlTaskAction new action: [ aCallback cull: aNotification cull: anElement ]).
			aNotification resume ].
]

{ #category : #executing }
BlTktNotifyingTask >> scheduleTaskExecutionFor: aRunner [
	^ self configureTaskExecution: BlTktNotifyingTaskExecution new with: aRunner
]

{ #category : #actions }
BlTktNotifyingTask >> suspendRequest [
	isSuspendRequested := true
]

{ #category : #executing }
BlTktNotifyingTask >> value [
	^ notifications maybeNotifyDuring: [ self task value ]
]
