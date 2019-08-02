Class {
	#name : #BlNotificableTaskItAction,
	#superclass : #BlEnqueuedTaskItAction,
	#instVars : [
		'runTasks',
		'notifications'
	],
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #accessing }
BlNotificableTaskItAction >> futureAction [
	^ [ notifications maybeNotifyDuring: [ self action value ] ] asBlTktCommand
			name: 'Maybe notifying action for ', self action name
]

{ #category : #initialization }
BlNotificableTaskItAction >> initialize [
	super initialize.
	notifications := BlTaskNotifications new.
	runTasks := OrderedCollection new.
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onNotification: aNotificationClass enqueueAction: aCallback [
	notifications 
		addNotification: aNotificationClass 
		handler: [ :aNotification | 
			self element enqueueTask: (BlTaskAction new 
				action: [ aCallback cull: aNotification cull: self ]).
			aNotification resume ].
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueAction: aCallback [
	| aTask |
	aTask := BlTaskAction new.
	aTask action: [ aCallback cull: self ].
	self onRunEnqueueTask: (aTask asBeaconLoggingTask maySetName: 'Run Action ', aCallback asString).
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueRepeatedAction: aCallback [
	| aTask |
	aTask := BlRepeatedTaskAction new.
	aTask delay: 200 milliSeconds.
	aTask action: aCallback.
	self onRunEnqueueRepeatedTask: aTask.
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueRepeatedTask: aTask [
	aTask element ifNil: [ aTask element: self element ].
	self onRunEnqueueTask: (aTask asBeaconLoggingTask maySetName: 'Repeated Task ', aTask asString).
	self onFinishedDo: [ :aResult | aTask stop ].
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onRunEnqueueTask: aBlTask [
	runTasks add: (aBlTask asBeaconLoggingTask maySetName: 'Run Action')
]

{ #category : #'api - running' }
BlNotificableTaskItAction >> run [
	runTasks do: [ :eachTask |
		self element enqueueTask: eachTask ].
	super run.
]
