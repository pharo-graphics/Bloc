Class {
	#name : #BlNotificableTaskItAction,
	#superclass : #BlEnqueuedTaskItAction,
	#instVars : [
		'runTasks',
		'notifications'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #accessing }
BlNotificableTaskItAction >> futureAction [
	^ [ BlSignalProgress 
		value: notifications isEmpty not
		during: [ [ self action value ] 
			on: (notifications collect: #notification)
			do: [ :aNotification | 
				notifications do: [ :eachHandler |
					eachHandler handle: aNotification ] ] ] ]
]

{ #category : #initialization }
BlNotificableTaskItAction >> initialize [
	super initialize.
	notifications := OrderedCollection new.
	runTasks := OrderedCollection new.
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onNotification: aNotificationClass enqueueAction: aCallback [
	| aHandler |
	aHandler := BlTaskNotificationHandler new.
	aHandler notification: aNotificationClass.
	aHandler handler: [ :aNotification | 
		self element enqueueTask: (BlTaskAction new 
			action: [ aCallback cull: aNotification cull: self ]).
		aNotification resume ].
	notifications add: aHandler.
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
