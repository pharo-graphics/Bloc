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
BlNotificableTaskItAction >> futureAction [
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
BlNotificableTaskItAction >> onNotification: aNotificationClass enqueueAction: aCallback [
	notification := aNotificationClass.
	handler := [ :aNotification | 
		self element enqueueTask: (BlTaskAction new 
			action: [ aCallback cull: aNotification cull: self ]).
		aNotification resume ].
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueAction: aCallback [
	| aTask |
	aTask := BlTaskAction new.
	aTask action: [ aCallback cull: self ].
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
