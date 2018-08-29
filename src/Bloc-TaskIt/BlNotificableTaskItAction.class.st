Class {
	#name : #BlNotificableTaskItAction,
	#superclass : #BlEnqueuedTaskItAction,
	#instVars : [
		'notification',
		'handler',
		'runTasks'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #accessing }
BlNotificableTaskItAction >> action [
	^ [ [ super action value ] 
			on: notification
			do: handler ]
]

{ #category : #initialization }
BlNotificableTaskItAction >> initialize [
	super initialize.
	handler := [ :aNotification | "do nothing" ].
	notification := BlTaskNotification.
	runTasks := OrderedCollection new.
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onNotification: aNotificationClass enqueueAction: aCallback in: anElement [
	notification := aNotificationClass.
	handler := [ :aNotification | 
		anElement enqueueTask: (BlTaskAction new action: [ aCallback value: aNotification ]).
		aNotification resume ].
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueAction: aCallback [
	| aTask |
	aTask := BlTaskAction new.
	aTask action: aCallback.
	self onRunEnqueueTask: aTask.
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueRepeatedAction: aCallback [
	| aTask |
	aTask := BlRepeatedTaskAction new.
	aTask delay: 30 milliSeconds.
	aTask action: aCallback.
	self onRunEnqueueRepeatedTask: aTask.
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueRepeatedTask: aTask [
	aTask element ifNil: [ aTask element: self element ].
	self onRunEnqueueTask: aTask.
	self onFinishedDo: [ :aResult | aTask stop ].
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueTask: aBlTask [
	runTasks add: aBlTask
]

{ #category : #'api - running' }
BlNotificableTaskItAction >> run [
	runTasks do: [ :eachTask |
		self element enqueueTask: eachTask ].
	super run.
]
