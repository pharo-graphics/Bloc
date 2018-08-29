Class {
	#name : #BlNotificableTaskItAction,
	#superclass : #BlEnqueuedTaskItAction,
	#instVars : [
		'notification',
		'handler'
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
]

{ #category : #'api - callbacks' }
BlNotificableTaskItAction >> onNotification: aNotificationClass enqueueAction: aCallback in: anElement [
	notification := aNotificationClass.
	handler := [ :aNotification | 
		anElement enqueueTask: (BlTaskAction new action: [ aCallback value: aNotification ]).
		aNotification resume ].
]
