Class {
	#name : #BlTaskNotificationHandler,
	#superclass : #Object,
	#instVars : [
		'notification',
		'handler'
	],
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #accessing }
BlTaskNotificationHandler >> handle: aNotification [
	aNotification class = self notification ifFalse: [ ^ self ].
	^ self handler cull: aNotification
]

{ #category : #accessing }
BlTaskNotificationHandler >> handler [
	^ handler
]

{ #category : #accessing }
BlTaskNotificationHandler >> handler: anObject [
	handler := anObject
]

{ #category : #accessing }
BlTaskNotificationHandler >> handles: aNotification [
	aNotification class = self notification ifFalse: [ ^ self ].
	^ self handler cull: aNotification
]

{ #category : #accessing }
BlTaskNotificationHandler >> notification [
	^ notification
]

{ #category : #accessing }
BlTaskNotificationHandler >> notification: anObject [
	notification := anObject
]
