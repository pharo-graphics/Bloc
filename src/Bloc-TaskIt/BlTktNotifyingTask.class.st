Class {
	#name : #BlTktNotifyingTask,
	#superclass : #BlTktDecoratedTask,
	#instVars : [
		'notifications',
		'isCancelRequested'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #converting }
BlTktNotifyingTask >> asNotifyingTask [
	^ self
]

{ #category : #actions }
BlTktNotifyingTask >> cancelRequest [
	isCancelRequested := true
]

{ #category : #initialization }
BlTktNotifyingTask >> initialize [
	super initialize.
	notifications := BlTaskNotifications new.
	isCancelRequested := false.
]

{ #category : #testing }
BlTktNotifyingTask >> isCancelRequested [
	^ isCancelRequested
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

{ #category : #executing }
BlTktNotifyingTask >> value [
	^ notifications maybeNotifyDuring: [ self task value ]
]
